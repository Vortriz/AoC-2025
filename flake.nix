{
    description = "Scientific dev environment with Julia";

    inputs = {
        # set your systems using: https://github.com/nix-systems/nix-systems?tab=readme-ov-file#available-system-flakes
        systems.url = "github:nix-systems/x86_64-linux";

        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        crane.url = "github:ipetkov/crane";
        flake-utils = {
            url = "github:numtide/flake-utils";
            inputs.systems.follows = "systems";
        };
        devshell = {
            url = "github:numtide/devshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs =
        {
            self,
            nixpkgs,
            crane,
            flake-utils,
            devshell,
            ...
        }:
        flake-utils.lib.eachDefaultSystem (
            system:
            let
                pkgs = import nixpkgs {
                    inherit system;
                    overlays = [ devshell.overlays.default ];
                };

                craneLib = crane.mkLib pkgs;

                # Pluto manages environment for each notebook independently,
                # so there is no need to include other Julia packages here.
                juliaEnv =
                    pkgs.julia-bin.withPackages.override
                        {
                            augmentedRegistry = (pkgs.callPackage ./_sources/generated.nix { }).registry.src;
                        }
                        [
                            "Pluto"
                            "LanguageServer"
                            "JuliaFormatter"
                        ];
            in
            {
                formatter = pkgs.treefmt.withConfig {
                    runtimeInputs = [
                        pkgs.nixfmt
                        juliaEnv
                    ];
                    settings = {
                        excludes = [ "_sources/**" ];
                        formatter.nixfmt = {
                            command = "nixfmt";
                            includes = [ "*.nix" ];
                            options = [ "--indent=4" ];
                        };
                    };
                };

                packages.default = craneLib.buildPackage {
                    src = craneLib.cleanCargoSource ./.;
                };

                devShells = {
                    default = self.devShells.${system}.julia;

                    julia = pkgs.devshell.mkShell {
                        name = "pluto-julia";
                        devshell.motd = "";

                        commands = [
                            {
                                name = "pluto";
                                category = "[julia]";
                                help = "Launch Pluto";
                                command = ''
                                    ${juliaEnv}/bin/julia -e "import Pluto; Pluto.run()"
                                '';
                            }
                            {
                                name = "jlfmt";
                                category = "[julia]";
                                help = "Format Julia files using JuliaFormatter";
                                command = ''
                                    ${juliaEnv}/bin/julia ${./fmt.jl}
                                '';
                            }
                        ];

                        env = [
                            {
                                name = "JULIA_NUM_THREADS";
                                value = "auto";
                            }
                            {
                                name = "julia";
                                value = "${juliaEnv}/bin/julia";
                            }
                        ];

                        packages = [
                            # for updating julia registry
                            pkgs.nvfetcher

                            juliaEnv
                        ];
                    };

                    rust = craneLib.devShell {

                    };
                };
            }
        );
}
