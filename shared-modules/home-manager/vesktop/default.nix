{ pkgs, config, lib, programs, monitors, ... }:
with lib;
let
    cfg = config.modules.vesktop;
in {
    options.modules.vesktop = { enable = lib.mkEnableOption "vesktop"; };

    config = mkIf cfg.enable {
        # configuration
        home.file = {
            ".config/vesktop/settings/quickCss.css".source = ./quickCss.css;
            ".local/share/fonts/seguiemj.ttf".source = ./seguiemj.ttf;
        };
    };
}