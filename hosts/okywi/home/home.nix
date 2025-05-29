{ config, pkgs, ...}: {
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
		linux-wallpaperengine
	];
}
