{ pkgs, config, lib, ... }:
with lib;
let
    cfg = config.modules.kitty;
in {
    options.modules.kitty = { enable = mkEnableOption "kitty"; };

    config = mkIf cfg.enable {
        # packages
        home.packages = with pkgs; [
            kitty
        ];

        home.sessionVariables = {
  	        TERMINAL = "kitty";
	    };

        # configuration
        home.file.".config/kitty".source = ../kitty;
    };
}