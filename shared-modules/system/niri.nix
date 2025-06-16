{ pkgs, config, lib, inputs, ... }:
with lib;
let cfg = config.modules.niri;
in {
  options.modules.niri = { enable = mkEnableOption "niri"; };

  config = mkIf cfg.enable {
    programs.niri = {
      enable = true;
    };

    services.gnome.gnome-keyring.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable  = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk # for GNOME apps
      ];
    };

    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  };
}
