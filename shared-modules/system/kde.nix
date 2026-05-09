{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.kde;
in {
  options.modules.kde = { enable = mkEnableOption "kde"; };

  config = mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;
  };
}
