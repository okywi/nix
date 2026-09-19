{ pkgs, config, ... }: {
  # import home modules
  imports = [ ../../../shared-modules/home-manager/default.nix ];

  # Select home modules
  config.modules = {
    git.enable = true;
    #sway.enable = true;
    niri.enable = true;
    #zsh.enable = true;
    signal.enable = true;
    fish.enable = true;
    btop.enable = true;
    eww.enable = true;
    kitty.enable = true;
    fastfetch.enable = true;
    easyeffects.enable = true;
    swaync.enable = true;
    rofi.enable = true;
    wireplumber.enable = false;
    qt.enable = true;
    gtk.enable = true;
    vesktop.enable = true;
  };

  # workspaces for sway/hyprland
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

      workspace "music" {
          open-on-output $secondary
      }
      workspace "chat" {
          open-on-output $secondary
      }
      workspace "browser2" {
          open-on-output $secondary
      }
      
    '';
  };

  config.my.startup = {
    niri = ''
      spawn-at-startup "iio-niri" "listen"
      spawn-sh-at-startup "sh -c $(wlsunset -t 3000 -T 3500)"
      spawn-sh-at-startup "~/.config/niri/scripts/wallpaper.sh"
      spawn-sh-at-startup "~/.config/eww/launch_eww.sh"
      spawn-sh-at-startup "sh -c steam"
      spawn-sh-at-startup "sh -c $(sleep 3; zapzap)"
      spawn-sh-at-startup "sh -c $(sleep 3; signal-desktop)"
      spawn-at-startup "copyq"
      spawn-sh-at-startup "sh -c $(killall swaync; swaync)"
      spawn-at-startup "blueman-applet"
      spawn-at-startup "mullvad-gui"
      spawn-sh-at-startup "sh -c $(sleep 3; pear-desktop)"
    '';
  };

  # Input for hyprland
  config.my.input = {
    sensitivity = 0;
    force_no_accel = true;
  };

  # eww
  config.my.eww = {
    hypr_workspaces = ''
      [0]="     "
      [1]="   "'';
    sway_workspaces = ''
      icons='[[[1, ""], [2, ""], [3, ""], [4, ""], [5, ""], [6, ""]], [[7, ""], [8, ""], [9, ""], [10, ""]]]'
    '';
    left_widgets = ''
      (launcher)
      (title)
      (metrics)
      (tray)
    '';
    right_widgets = ''
      (rebuild)
      (musicbar)
      (weather)
      (microphone)
      (audio)
      (clock)
      (notifications)
      (power)
    '';
    bar = ''
      $EWW open-many \
        bar:primary --arg primary:screen="1" --arg primary:wsscreen="0" \
        bar:secondary --arg secondary:screen="0" --arg secondary:wsscreen="1"
    '';
  };
}
