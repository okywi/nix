{ pkgs, config, home-manager, ... }: {
  imports = [ ./config.nix ];

  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maya-laptop = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "maya-laptop";
    extraGroups = [ "networkmanager" "wheel" "storage" "disk" "plugdev" "input" "video" "syncthing" "docker" ];
  };

  services.syncthing = {
    enable = true;
    user = "maya-laptop";
    dataDir = "/home/maya-laptop";
    configDir = "/home/maya-laptop/.config/syncthing";
    openDefaultPorts = true;
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
  };

  # Pass `my.monitors` as an argument to Home Manager
  home-manager.users.maya-laptop = {
    _module.args = {
      monitors = config.my.monitors; # Pass to HM
    };
  };

	home-manager.backupFileExtension = "home-manager-backup";
}
