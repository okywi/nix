{ ... }: {
  imports = [
		./config.nix
	];
  
	home = {
		username = "okywi-laptop";
		homeDirectory = "/home/okywi-laptop";
		stateVersion = "25.05";
	};

	programs.home-manager.enable = true;
}
