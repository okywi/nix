{ pkgs, config, lib, ... }:
with lib;
let 
  cfg = config.modules.qt;
  catppuccin_colors = "${builtins.readFile ./colors.conf}";
  base_config = "${builtins.readFile ./qt-settings.conf}";
in {
  options.modules.qt = { enable = mkEnableOption "qt"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ adwaita-qt adwaita-qt6 darkly darkly-qt5 rose-pine-kvantum ];

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "adwaita-qt";
      qt5ctSettings =  {
        Appearance = {
          style = "Adwaita-Dark";
          icon_theme = "Papirus-Dark";
          standard_dialogs = "xdgdesktopportal";
          color_scheme_path = "/home/${config.home.username}/.config/qt5ct/colors/Catppuccin-Mocha.conf";
          custom_palette = true;
        };
        Fonts = {
         fixed = "\"DejaVuSansM Nerd Font Mono,12\"";
         general = "\"DejaVu Sans,12\"";
       };
     };
     qt6ctSettings =  {
        Appearance = {
          style = "Adwaita-Dark";
          icon_theme = "Papirus-Dark";
          standard_dialogs = "xdgdesktopportal";
          color_scheme_path = "/home/${config.home.username}/.config/qt6ct/colors/Catppuccin-Mocha.conf";
          custom_palette = true;
        };
        Fonts = {
         fixed = "\"DejaVuSansM Nerd Font Mono,12\"";
         general = "\"DejaVu Sans,12\"";
       };
     };
    };

    xdg.configFile."qt5ct/colors/Catppuccin-Mocha.conf".text = catppuccin_colors;
    xdg.configFile."qt6ct/colors/Catppuccin-Mocha.conf".text = catppuccin_colors;

    #xdg.configFile = {
    #"Kvantum/rose-pine-moon-iris".source = "${pkgs.rose-pine-kvantum}/share/Kvantum/themes/rose-pine-moon-iris";
    #"Kvantum/kvantum.kvconfig".text = ''
    #  [General]
    #  theme=rose-pine-moon-iris
    #'';
    
   # xdg.configFile = {
      #  "qt5ct/qt5ct.conf".text = builtins.replaceStrings ["qtXct"] ["qt5ct"] base_config;
      #  "qt6ct/qt6ct.conf".text = builtins.replaceStrings ["qtXct"] ["qt6ct"] base_config;
      #};

      
    #};
  };

    
}
