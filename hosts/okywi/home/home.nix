{ config, pkgs, lib, ...}: {
  imports = [
		./config.nix
	];
  
	home = {
		username = "okywi";
		homeDirectory = "/home/${config.home.username}";
		stateVersion = "25.05";
	};

	programs.home-manager.enable = true;

  home.packages = with pkgs; [
	] ++ lib.optional config.modules.hyprland.enable linux-wallpaperengine
    ++ lib.optional config.modules.niri.enable mpvpaper;
}
