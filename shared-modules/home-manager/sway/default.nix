{ pkgs, config, lib, programs, monitors, ... }:
with lib;
let
    cfg = config.modules.sway;
in {
    options.modules.sway = { enable = lib.mkEnableOption "sway"; };

    config = mkIf cfg.enable {
        # packages
        home.packages = with pkgs; [
            swayfx
            swaybg
            brightnessctl
        ];

        # configuration
        home.file = {
            ".config/sway/config".source = ./config;
            ".config/sway/scripts".source = ./scripts;
            ".config/sway/outputs".text = builtins.concatStringsSep "\n" monitors.sway;
        };
    };
}