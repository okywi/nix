{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #hytale-launcher.url = "github:JPyke3/hytale-launcher-nix";
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lazyvim = {
      url = "github:pfassina/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-flatpak, lazyvim, ... }@inputs:
  
    let 
      system = "x86_64-linux";
      overlays = [
        (final: prev: {
          limusic = prev.callPackage ./pkgs/limusic { };
        })
      ];
    in {
      overlays.default = nixpkgs.lib.composeManyExtensions overlays;
      nixosConfigurations.maya-pc = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit system;
          #pkgs-unstable = import inputs.nixpkgs-unstable {
          #  inherit system;
          #  config.allowUnfree = true;
          #};
        }; 
        
        modules = [
          { nixpkgs.overlays = overlays; }
          ./hosts/maya/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.overwriteBackup = true;
            home-manager.users.maya = import ./hosts/maya/home/home.nix;
            home-manager.backupFileExtension = "home-manager-backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };

      nixosConfigurations.okywi-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit system;
        };
        modules = [
          { nixpkgs.overlays = overlays; }
          ./hosts/okywi-laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.overwriteBackup = true;
            home-manager.users.okywi-laptop = import ./hosts/okywi-laptop/home/home.nix;
            home-manager.backupFileExtension = "home-manager-backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
          }

          nix-flatpak.nixosModules.nix-flatpak
        ];
      };

      nixosConfigurations.maya-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit system;
        };
        modules = [
          { nixpkgs.overlays = overlays; }
          ./hosts/maya-laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.overwriteBackup = true;
            home-manager.users.maya-laptop = import ./hosts/maya-laptop/home/home.nix;
            home-manager.backupFileExtension = "home-manager-backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
    };
}
