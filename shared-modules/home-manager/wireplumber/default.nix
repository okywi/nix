{ pkgs, config, lib, ... }:
with lib;
let
    cfg = config.modules.wireplumber;
in {
    options.modules.wireplumber = { enable = mkEnableOption "wireplumber"; };

    config = mkIf cfg.enable {
        # packages
        home.packages = with pkgs; [
        ];

        # configuration
        # home.file.".config/wireplumber/wireplumber.conf.d/alsa-soft-mixer.conf".source = ./alsa-soft-mixer.conf;
        # home.file.".config/wireplumber/wireplumber.conf.d/alsa-disable-suspension.conf".source = ./alsa-disable-suspension.conf;        
    };
}