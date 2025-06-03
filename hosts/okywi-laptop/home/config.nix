{ pkgs, config, ... }: {
  # import home modules
	imports = [
    ../../../shared-modules/home-manager/default.nix
	];

  # Select home modules
  config.modules = {
    # sway.enable = true
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
    git.enable = true;
  };

  config.my.workspaces = {
    hyprland = ''
      workspace=1, persistent:true, monitor:$primary
      workspace=2, persistent:true, monitor:$primary
      workspace=3, persistent:true, monitor:$primary
      workspace=4, persistent:true, monitor:$primary
      workspace=5, persistent:true, monitor:$primary
      workspace=6, persistent:true, monitor:$primary
      workspace=7, persistent:true, monitor:$primary
      workspace=8, persistent:true, monitor:$primary
      workspace=9, persistent:true, monitor:$primary
      workspace=10, persistent:true, monitor:$primary
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
      (title)
      (metrics)
      (tray)
    '';
    right_widgets = ''
      (twitch)
      (rebuild)
      (spotify)
      (weather)
      (battery)
      (audio)
      (clock)
      (notifications)
      (power)
    '';
  };
}