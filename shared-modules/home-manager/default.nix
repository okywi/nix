{
	imports = [
		./hypr
		./vesktop
		./sway
		./niri
		./gnome
		./eww
		./zsh
		./kitty
		./fastfetch
		./swaync
		./rofi
		./wireplumber
		./gtk
		./qt
		./git
		./options.nix
	];

	home.file.".wallpapers".source = ./wallpapers;
}
