{
  description = "Meine NixOS Konfiguration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, ... } @ inputs : {
    nixosConfigurations = {

      # ---- Framework Laptop ----
      framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./configuration.nix
          ./hosts/framework/framework.nix
          { networking.hostName = "framework"; }

          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hrolgard = import ./home/hrolgard.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              system = "x86_64-linux";
            };
          }
        ];
      };

      # ---- Desktop PC (Steam + NVIDIA) ----
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./configuration.nix
          ./hosts/desktop/desktop.nix
          { networking.hostName = "desktop"; }

          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hrolgard = import ./home/hrolgard.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              system = "x86_64-linux";
            };
          }
        ];
      };

    };
  };
}
