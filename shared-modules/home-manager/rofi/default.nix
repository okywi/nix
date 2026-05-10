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

        home.file.".rofi-cache/rofi3.druncache".source = ./rofi3.druncache;

        programs.rofi = {
            enable = true;
            package = pkgs.rofi;
            plugins = [
                pkgs.rofi-emoji
                pkgs.rofi-calc
            ];
        };
    };
}