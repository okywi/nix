{ pkgs, ... }: {
  imports = [
    # import system modules
    ../../../shared-modules/system/default.nix

    # import specific system modules
    ./modules/default.nix
  ];

  # Select modules
  config.modules = {
    sddm.enable = true;
    redshift.enable = true;
    #hyprland.enable = true;
    #sway.enable = true;
    niri.enable = true;
    storage.enable = true;
    audio.enable = true;
    power.enable = true;
    nautilus.enable = true;
    fonts.enable = true;
    network.enable = true;
    userPackages.enable = true;
  };

  # Define monitors
  config.my.monitors = {
    hyprland = [
      "DP-3,1920x1080@165,1920x0,1"
      "HDMI-A-1,1920x1080@60,0x0,1"
    ];
    sway = [ 
      "output DP-3 scale 1 resolution 1920x1080@165Hz position 1920,0"
      "output HDMI-A-1 scale 1 resolution 1920x1080@60Hz position 0,0"
    ];
  };
}