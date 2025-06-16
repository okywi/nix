{
	imports = [
		./hypr
		./sway
		./niri
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
