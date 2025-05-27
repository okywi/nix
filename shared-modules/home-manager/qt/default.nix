{ pkgs, config, lib, ... }:
with lib;
let 
  cfg = config.modules.qt;
  catppuccin_colors = "${builtins.readFile ./colors.conf}";
  base_config = "${builtins.readFile ./qt-settings.conf}";
in {
  options.modules.qt = { enable = mkEnableOption "qt"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ darkly darkly-qt5 ];

    qt = {
      enable = true;
      platformTheme.name = "qtct";
    };

    xdg.configFile = {
      "qt5ct/qt5ct.conf".text = builtins.replaceStrings ["qtXct"] ["qt5ct"] base_config;
      "qt6ct/qt6ct.conf".text = builtins.replaceStrings ["qtXct"] ["qt6ct"] base_config;
    };

    xdg.configFile."qt5ct/colors/Catppuccin-Mocha.conf".text = catppuccin_colors;
    xdg.configFile."qt6ct/colors/Catppuccin-Mocha.conf".text = catppuccin_colors;
  };
}
