{ pkgs, config, lib, inputs, ... }:
with lib;
let cfg = config.modules.power;
in {
  options.modules.power = { enable = mkEnableOption "power"; };

  config = mkIf cfg.enable {
    services.power-profiles-daemon.enable = false;
  };
}