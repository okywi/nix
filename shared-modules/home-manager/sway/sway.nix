{ pkgs, config, lib, monitors, ... }:
with lib;
let
  cfg = config.modules.sway;

  input = config.my.input;
  getSecond = list:
    if builtins.length list < 2 then
      "null"
    else
      builtins.head (builtins.tail list);

  primary =
    builtins.elemAt (lib.splitString " " (builtins.elemAt monitors.sway 0)) 1;
  secondary = builtins.elemAt (lib.splitString " " (getSecond monitors.sway)) 1;
in {
  config = mkIf cfg.enable {
    # wayland scaling issue fixs
    home.sessionVariables.NIXOS_OZONE_WL = "1";

    # Hyprland
    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.swayfx;
      checkConfig = false;

      config = {
        seat = {
          "*" = {
            xcursor_theme = "${config.gtk.cursorTheme.name} ${
                toString config.gtk.cursorTheme.size
              }";
          };
        };
        keybindings = { };
        modes = { };
        bars = [ ];
        colors = {
          focused = {
            background = "#F4B8E4";
            border = "#F4B8E4";
            childBorder = "#F4B8E4";
            indicator = "#F4B8E4";
            text = "#FFFFFF";
          };
          focusedInactive = {
            background = "#181818";
            border = "#181818";
            childBorder = "#181818";
            indicator = "#181818";
            text = "#181818";
          };
          unfocused = {
            background = "#181818";
            border = "#181818";
            childBorder = "#181818";
            indicator = "#181818";
            text = "#cccccc";
          };
          urgent = {
            background = "#E6A1AD";
            border = "#E6A1AD";
            childBorder = "#E6A1AD";
            indicator = "#E6A1AD";
            text = "#FFFFFF";
          };
          placeholder = {
            background = "#181818";
            border = "#181818";
            childBorder = "#181818";
            indicator = "#181818";
            text = "#181818";
          };
        };
      };

      extraConfigEarly = ''
        set $primary ${primary}
        set $secondary ${secondary}
      '';

      extraConfig = ''
        include ./conf/variables
        include ./conf/inputs
        include ./conf/outputs
        include ./conf/appearance
        include ./conf/bindings
        include ./conf/windows
        include ./conf/workspaces
        include ./conf/autostart

        include @sysconfdir@/sway/config.d/*
      '';
    };
  };
}
