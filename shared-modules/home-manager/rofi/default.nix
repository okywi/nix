{ pkgs, config, lib, ... }:
with lib;
let
    cfg = config.modules.rofi;
in {
    options.modules.rofi = { enable = mkEnableOption "rofi"; };

    config = mkIf cfg.enable {
        # eww package
        home.packages = with pkgs; [
          hyprshot
          slurp
          grim
          wl-screenrec
        ];

        # configuration
        home.file.".config/rofi".source = ../rofi;

        programs.rofi = {
            enable = true;
            package = pkgs.rofi-wayland;
            plugins = [
                pkgs.rofi-emoji
                pkgs.rofi-calc
            ];
        };
    };
}