{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-flatpak.url = "github:gmodena/nix-flatpak/";
    niri.url = "github:sodiboo/niri-flake";
    chromium-webapps.url = "github:chobbledotcom/nix-chromium-webapps";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-flatpak, ... }@inputs:
    let system = "x86_64-linux";
    in {
      nixosConfigurations.okywi = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit system;
        };
        modules = [
          ./hosts/okywi/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.okywi = import ./hosts/okywi/home/home.nix;
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
          ./hosts/okywi-laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.okywi-laptop = import ./hosts/okywi-laptop/home/home.nix;
          }
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
    };
}
