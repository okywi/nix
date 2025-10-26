{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.btop;
in {
  options.modules.btop = { enable = mkEnableOption "btop"; };

  config = mkIf cfg.enable {
    xdg.configFile."btop/themes/catppuccin_mocha.theme".source = ./catppuccin_mocha.theme;
    xdg.configFile."btop/btop.conf".source = ./btop.conf;
  };
}
