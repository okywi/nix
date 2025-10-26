{ inputs, ... }:
{
	imports = [
		./vesktop
		./sway
		./niri
		./gnome
		./eww
		./zsh
		./btop
		./fish
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
