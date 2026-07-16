{
    description = "Meine NixOS Konfiguration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }: {
        nixosConfigurations = {
            framework = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";

                modules = [
                    ./configuration.nix

                    {
                        nixpkgs.config.allowUnfree = true;
                    }

                    home-manager.nixosModules.home-manager

                    {
                        home-manager.users.hrolgard = import ./home.nix;
                    }
                ];
            };
        };
    };
}
