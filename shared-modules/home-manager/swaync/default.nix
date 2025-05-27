{ pkgs, config, lib, ... }:
with lib;
let
    cfg = config.modules.swaync;
in {
    options.modules.swaync = { enable = mkEnableOption "swaync"; };

    config = mkIf cfg.enable {
        # packages
        home.packages = with pkgs; [
            swaynotificationcenter
        ];

        # configuration
        home.file.".config/swaync".source = ../swaync;
    };
}