{ pkgs, config, lib, ... }:
with lib;
let 
  cfg = config.modules.signal;
in {
  options.modules.signal = { enable = mkEnableOption "signal"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ signal-desktop ];

    xdg.configFile = {
      "signal/ephemeral.json".source = ./ephemeral.json;
    };
  };
}
