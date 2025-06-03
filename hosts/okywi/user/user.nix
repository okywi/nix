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
    extraGroups = [ "networkmanager" "wheel" "storage" "disk" "openrazer" "plugdev" ];
  };

  
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
  };

  # Pass `my.monitors` as an argument to Home Manager
  home-manager.users.okywi = {
    _module.args = {
      monitors = config.my.monitors;
    };
  };
}
