{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.gnome;
in {
  options.modules.gnome = { enable = mkEnableOption "gnome"; };

  config = mkIf cfg.enable {
    services.xserver = {
      desktopManager.gnome = {
        enable = true;
      };
    };
    hardware.sensor.iio.enable = true;
  };
}
