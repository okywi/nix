{ pkgs, config, lib, programs, monitors, ... }:
with lib;
let
    cfg = config.modules.sway;
in {
    imports = [
        ./sway.nix
    ];

    options.modules.sway = { enable = lib.mkEnableOption "sway"; };

    config = mkIf cfg.enable {
        # packages
        home.packages = with pkgs; [
            swaybg
            brightnessctl
        ];

        # configuration
        home.file = {
            ".config/sway/sway_config".source = ./sway_config;
            ".config/sway/scripts".source = ./scripts;
            ".config/sway/outputs".text = builtins.concatStringsSep "\n" monitors.sway;
        };
    };
}