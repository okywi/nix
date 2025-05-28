{ pkgs, config, lib, monitors, ... }:
with lib;
let
  cfg = config.modules.hyprland;
  username = config.home.username;
  getSecond = list:
    if builtins.length list < 2 then
      "null"
    else
      builtins.head (builtins.tail list);

  primary =
    builtins.head (lib.splitString "," (builtins.elemAt monitors.hyprland 0));
  secondary = builtins.head (lib.splitString "," (getSecond monitors.hyprland));
in {
  config = mkIf cfg.enable {
    # wayland scaling issue fixs
    home.sessionVariables.NIXOS_OZONE_WL = "1";

    # Hyprland
    wayland.windowManager.hyprland = {
      enable = true;
      plugins = [ pkgs.hyprlandPlugins.hyprgrass ];

      settings = {
        monitor = monitors.hyprland;
        input = {
          sensitivity = if username == "okywi-laptop" then 0 else 0;
          kb_layout = "de";
          touchpad = { natural_scroll = false; };
          accel_profile = "flat";
          force_no_accel = if username == "okywi-laptop" then false else true;
        };
      };

      extraConfig = ''
        exec-once = ./scripts/portals.sh

        $primary = ${primary}
        $secondary = ${secondary}

        source = ./hyprland/autostart.conf
        source = ./hyprland/variables.conf
        source = ./hyprland/env.conf
        source = ./hyprland/appearance.conf
        source = ./hyprland/keybinds.conf
        source = ./hyprland/windows.conf
        source = ./hyprland/workspaces.conf

        exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      '';
    };
  };
}
