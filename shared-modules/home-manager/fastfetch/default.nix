{ pkgs, config, lib, ... }:
with lib;
let
    cfg = config.modules.fastfetch;
in {
    options.modules.fastfetch = { enable = mkEnableOption "fastfetch"; };

    config = mkIf cfg.enable {
        # packages
        home.packages = with pkgs; [
            fastfetch
        ];

        # configuration
        home.file.".config/fastfetch".source = ../fastfetch;
    };
}