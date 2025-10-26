{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.btop;
in {
  options.modules.btop = { enable = mkEnableOption "btop"; };

  config = mkIf cfg.enable {
    home.configFile."btop/themes/catppuccin_mocha.theme" = ./catppuccin_mocha.theme;
  };
}
