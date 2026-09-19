{ inputs, ... }:
{
	imports = [
		./vesktop
		./signal
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
		./easyeffects
		./gtk
		./qt
		./git
		./options.nix
	];


	home.file.".wallpapers".source = ./wallpapers;
}
