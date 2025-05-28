{ config, pkgs, username, ...}:
{
  imports = [ ./config.nix ];
  
	home = {
		username = "${username}";
		homeDirectory = "/home/${username}";
		stateVersion = "25.05";
	};

	programs.home-manager.enable = true;
}
