{ pkgs, config, username, ... }: {
  imports = [ ./config.nix ];
  
  # enable zsh
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "storage" "disk" ];
  };

  # Define monitors
  my.monitors = {
    hyprland = [
      "eDP-1,2560x1600@165,0x0,1.6"
    ];
    sway = [ 
      "output eDP-1 scale 1.5 resolution 2560x1600@165Hz position 0,0"
    ];
  };

  # Pass `my.monitors` as an argument to Home Manager
  home-manager.users.${username} = {
    _module.args = {
      monitors = config.my.monitors; # Pass to HM
      username = username;
    };
  };
}
