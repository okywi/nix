{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.sway;
in {
  options.modules.sway = { enable = mkEnableOption "sway"; };

  config = mkIf cfg.enable {
    # polkit
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;

    # XDG PORTALS
    xdg.portal = {
      enable = true;
      wlr.enable  = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk # for GNOME apps
      ];
    };

    # Program
    programs.sway = {
       enable = true;
       wrapperFeatures.gtk = true;
       package = pkgs.swayfx;
     };
  };
}