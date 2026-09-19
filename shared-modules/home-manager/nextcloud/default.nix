{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.nextcloud;
in {
  options.modules.nextcloud = { enable = mkEnableOption "nextcloud"; };

  config = mkIf cfg.enable {
    home.file.".config/Nextcloud/sync-exclude.lst".source = ./sync-exclude.lst;
    home.file.".config/Nextcloud/sync-exclude.lst".force = true;
  };
}
