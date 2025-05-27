{ pkgs, config, ... }: {
  # import home modules
	imports = [
    ../../../shared-modules/home-manager/default.nix
	];

  # Select home modules
  config.modules = {
    git.enable = true;
    #sway.enable = true;
		zsh.enable = true;
    hyprland.enable = true;
    eww.enable = true;
    kitty.enable = true;
    fastfetch.enable = true;
    swaync.enable = true;
    rofi.enable = true;
    wireplumber.enable = false;
    qt.enable = true;
    gtk.enable = true;
  };
}