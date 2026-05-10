{ config, pkgs, lib, ...}: {
  imports = [
		./config.nix
	];
  
	home = {
		username = "maya";
		homeDirectory = "/home/${config.home.username}";
		stateVersion = "25.11";
	};

	programs.home-manager.enable = true;

  home.packages = with pkgs; [
	] ++ lib.optional config.modules.sway.enable mpvpaper
    ++ lib.optional config.modules.niri.enable mpvpaper;
}
