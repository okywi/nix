{ inputs, ... }: {
  imports = [
		./config.nix
	];
  
	home = {
		username = "maya-laptop";
		homeDirectory = "/home/maya-laptop";
		stateVersion = "26.05";
	};


	programs.home-manager.enable = true;

	xdg.configFile."mimeapps.list".text = ''
[Default Applications]
x-scheme-handler/http=zen-beta.desktop
x-scheme-handler/https=zen-beta.desktop
x-scheme-handler/chrome=zen-beta.desktop
text/html=zen-beta.desktop
application/x-extension-htm=zen-beta.desktop
application/x-extension-html=zen-beta.desktop
application/x-extension-shtml=zen-beta.desktop
application/xhtml+xml=zen-beta.desktop
application/x-extension-xhtml=zen-beta.desktop
application/x-extension-xht=zen-beta.desktop
x-scheme-handler/discord-1216669957799018608=discord-1216669957799018608.desktop
x-scheme-handler/discord=vesktop.desktop
image/jpeg=org.gnome.Loupe.desktop
application/pdf=zen-beta.desktop
application/vnd.oasis.opendocument.text=writer.desktop
x-scheme-handler/bitwarden=bitwarden.desktop
application/vnd.openxmlformats-officedocument.wordprocessingml.document=writer.desktop
image/gif=org.gnome.Loupe.desktop
image/png=org.gnome.Loupe.desktop
image/svg+xml=org.gnome.Loupe.desktop

[Added Associations]
x-scheme-handler/http=zen-beta.desktop;
x-scheme-handler/https=zen-beta.desktop;
x-scheme-handler/chrome=zen-beta.desktop;
text/html=zen-beta.desktop;
application/x-extension-htm=zen-beta.desktop;
application/x-extension-html=zen-beta.desktop;
application/x-extension-shtml=zen-beta.desktop;
application/xhtml+xml=zen-beta.desktop;
application/x-extension-xhtml=zen-beta.desktop;
application/x-extension-xht=zen-beta.desktop;
image/jpeg=org.gnome.Loupe.desktop;
application/pdf=zen-beta.desktop;
application/vnd.oasis.opendocument.text=writer.desktop;
application/vnd.openxmlformats-officedocument.wordprocessingml.document=writer.desktop;
image/gif=org.gnome.Loupe.desktop;
image/png=org.gnome.Loupe.desktop;
image/svg+xml=org.gnome.Loupe.desktop;
	'';
  xdg.configFile."mimeapps.list".force = true;
}
