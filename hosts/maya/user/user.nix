{ pkgs, lib, config, inputs, ... }: {
  
  imports = [ 
    ./config.nix
  ];

  # enable fish
  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maya = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "maya";
    extraGroups = [ "video" "input" "networkmanager" "wheel" "storage" "disk" "openrazer" "plugdev" "docker" ];
  };

  services.syncthing = {
    enable = true;
    user = "maya";
    dataDir = "/home/maya";
    configDir = "/home/maya/.config/syncthing";
  };
  
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
  };

  # Pass `my.monitors` as an argument to Home Manager
  home-manager.users.maya = {
    _module.args = {
      monitors = config.my.monitors;
    };
  };

  xdg.icons = {
    enable = true;
    fallbackCursorThemes = [ "StrawberryMicro" ];
  };
}
