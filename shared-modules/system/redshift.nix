{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.redshift;
in {
  options.modules.redshift = { enable = mkEnableOption "redshift"; };

  config = mkIf cfg.enable {
    location.latitude = 47.728569;
    location.longitude = 10.315784;

    services.redshift = {
      enable = true;
      brightness = {
        # Note the string values below.
        day = "0.1";
        night = "0.1";
      };
      temperature = {
        day = 3500;
        night = 3000;
      };
    };
  };
}
