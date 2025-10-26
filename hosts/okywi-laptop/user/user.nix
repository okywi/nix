{ pkgs, config, home-manager, ... }: {
  imports = [ ./config.nix ];

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.okywi-laptop = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "okywi-laptop";
    extraGroups = [ "networkmanager" "wheel" "storage" "disk" "plugdev" "input" "video" ];
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
  };

  # Pass `my.monitors` as an argument to Home Manager
  home-manager.users.okywi-laptop = {
    _module.args = {
      monitors = config.my.monitors; # Pass to HM
    };
  };

	home-manager.backupFileExtension = "backup";
}
