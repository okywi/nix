{ pkgs, config, ... }: {
  # import home modules
  imports = [ ../../../shared-modules/home-manager/default.nix ];

  # Select home modules
  config.modules = {
    git.enable = true;
    #sway.enable = true;
    zsh.enable = true;
    hyprland.enable = true;
    eww.enable = true;
    kitty.enable = true;
    fastfetch.enable = true;
    swaync.enable = true;
    rofi.enable = true;
    wireplumber.enable = false;
    qt.enable = true;
    gtk.enable = true;
  };

  # workspaces for sway/hyprland
  config.my.workspaces = {
    hyprland = ''
      workspace=1, persistent:true, monitor:$primary
      workspace=2, persistent:true, monitor:$primary
      workspace=3, persistent:true, monitor:$primary
      workspace=4, persistent:true, monitor:$primary
      workspace=5, persistent:true, monitor:$primary
      workspace=6, persistent:true, monitor:$primary
      workspace=7, persistent:true, monitor:$secondary
      workspace=8, persistent:true, monitor:$secondary
      workspace=9, persistent:true, monitor:$secondary
      workspace=10, persistent:true, monitor:$secondary
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
      icons=("" "" "" "" "" "" "" "" "" "") 
    '';
    left_widgets = ''
      (launcher)
      (title)
      (metrics)
      (tray)
    '';
    right_widgets = ''
      (twitch)
      (rebuild)
      (spotify)
      (weather)
      (microphone)
      (audio)
      (clock)
      (notifications)
      (power)
    '';
  };
}
