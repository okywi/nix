{ pkgs, config, lib, ... }:
with lib;
let 
  cfg = config.modules.niri;
in {
  options.modules.niri = { enable = mkEnableOption "niri"; };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      xwayland-satellite
      swww
      wlsunset
    ];

    xdg.configFile = {
      "niri/config.kdl".source = ./config.kdl;
      "niri/scripts".source = ./scripts;
    };
  };
}
