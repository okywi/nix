{ pkgs, ... }: {
  imports = [ 
    # import system modules
    ../../../shared-modules/system/default.nix

    # import specific system modules
    ./modules/default.nix
  ];

  # Select modules
  config.modules = {
    niri.enable = true;
    sddm.enable = true;
    redshift.enable = true;
    # hyprland.enable = true;
    gnome.enable = false;
    storage.enable = true;
    audio.enable = true;
    power.enable = true;
    nautilus.enable = true;
    fonts.enable = true;
    network.enable = true;
  };

  # Define monitors
  config.my.monitors = {
    sway = [
      "output eDP-1 scale 1.5 resolution 2560x1600@165Hz position 0,0"
    ];
    niri = [
      ''
        output "eDP-1" {
          mode "2560x1600@165"
          scale 1.5
          transform "normal"
          position x=0 y=0
          focus-at-startup
        }
      ''
    ];
  };
}