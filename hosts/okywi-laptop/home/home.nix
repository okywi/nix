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

	xdg.mimeApps = {
		enable = true;
		defaultApplications = {
  		"text/html" = "zen-beta.desktop";
			"x-scheme-handler/http" = "zen-beta.desktop";
			"x-scheme-handler/https" = "zen-beta.desktop";
			"x-scheme-handler/about" = "zen-beta.desktop";
			"x-scheme-handler/unknown" = "zen-beta.desktop";
			"application/pdf" = "zen-beta.desktop";
			"application/vnd.oasis.opendocument.text" = "writer.desktop";
		};
	};

  xdg.configFile."mimeapps.list".force = true;
}
