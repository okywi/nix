{ config, pkgs, username, ...}: {
  imports = [
		./config.nix
	];
  
	home = {
		username = username;
		homeDirectory = "/home/${username}";
		stateVersion = "25.05";
	};

	home.packages = with pkgs; [
		linux-wallpaperengine
	];

	programs.home-manager.enable = true;
}
