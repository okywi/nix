{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.gtk;
in {
  options.modules.gtk = { enable = mkEnableOption "gtk"; };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      gtk-engine-murrine
    ];
    
    # GTK Theme
    gtk = {
      enable = true;
      theme = {
        /*name = "";
        package = pkgs.catppuccin-gtk.override {
          accent = [ "pink" ];
          size = "standard";
          variant = "dark";
          variant = [ "" ];
        };*/
        name = "catppuccin-mocha-pink-standard";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "pink" ];
          size = "standard";
          variant = "mocha";
        };
        # package = pkgs.dracula-theme;
      };

      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };

      cursorTheme = {
        name = "Banana";
        package = pkgs.banana-cursor;
      };

      gtk3.bookmarks = [
        "file:///home/${config.home.username}/Documents"
        "file:///home/${config.home.username}/Downloads"
        "file:///home/${config.home.username}/Pictures"
        "file:///home/${config.home.username}/Videos"
        "file:///home/${config.home.username}/Music"
      ];
    };
  };
}
