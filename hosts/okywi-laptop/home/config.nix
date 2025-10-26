{ pkgs, config, ... }: {
  # import home modules
	imports = [
    ../../../shared-modules/home-manager/default.nix
	];

  # Select home modules
  config.modules = {
    #sway.enable = true
		niri.enable = true;
    zsh.enable = true;
    fish.enable = false;
    #hyprland.enable = true;
    btop.enable = true;
    gnome.enable = true;
    eww.enable = true;
    kitty.enable = true;
    fastfetch.enable = true;
    swaync.enable = true;
    rofi.enable = true;
    qt.enable = true;
    gtk.enable = true;
    git.enable = true;
    vesktop.enable = true;
  };

  config.my.workspaces = {
    niri = ''
      workspace "terminal" {
          open-on-output $primary
      }
      workspace "browser" {
          open-on-output $primary
      }
      workspace "coding" {
          open-on-output $primary
      }
      workspace "gaming" {
          open-on-output $primary
      }
      workspace "spotify" {
          open-on-output $primary
      }
      workspace "chat" {
          open-on-output $primary
      }
    '';
  };

  config.my.input = {
    sensitivity = 0;
    force_no_accel = false;
  };
  
  # eww
  config.my.eww = {
    hypr_workspaces = ''
    [0]="         "
    '';
    sway_workspaces = ''
      icons=("" "" "" "" "" "" "" "" "" "") 
    '';
    left_widgets = ''
      (launcher)
      (overview)
      (title)
      (keyboard)
      (metrics)
      (tray)
    '';
    right_widgets = ''
      (twitch)
      (spotify)
      (weather)
      (battery)
      (audio)
      (clock)
      (notifications)
      (power)
    '';
    bar = ''$EWW open bar --arg screen="0" --arg wsscreen="0"'';
  };
}