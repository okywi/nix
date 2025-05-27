{ pkgs, config, lib, inputs, ... }:
with lib;
let cfg = config.modules.hyprland;
in {
  options.modules.hyprland = { enable = mkEnableOption "hyprland"; };

  config = mkIf cfg.enable {
    # polkit
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;

    # XDG PORTALS
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk # for GNOME apps
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
      ];
    };

    # Programs
    programs = {
      hyprland = {
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        enable = true;
        xwayland.enable = true;
      };
      iio-hyprland.enable = true;
      hyprlock.enable = true;
    };
  };
}
