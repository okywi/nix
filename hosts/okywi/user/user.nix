{ pkgs, lib, config, inputs, ... }: {
  
  imports = [ 
    ./config.nix
  ];

  # enable zsh
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.okywi = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "okywi";
    extraGroups = [ "networkmanager" "wheel" "storage" "disk" ];
  };

  # Define monitors
  my.monitors = {
    hyprland = [
      "DP-3,1920x1080@165,1920x0,1"
      "HDMI-A-1,1920x1080@60,0x0,1"
    ];
    sway = [ 
      "output DP-3 scale 1 resolution 1920x1080@165Hz position 1920,0"
      "output HDMI-A-1 scale 1 resolution 1920x1080@60Hz position 0,0"
    ];
  };

  # Pass `my.monitors` as an argument to Home Manager
  home-manager.users.okywi = {
    _module.args = {
      monitors = config.my.monitors;
    };
  };
}
