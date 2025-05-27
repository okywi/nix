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
    hyprland.enable = true;
    sway.enable = true;
    storage.enable = true;
    audio.enable = true;
    power.enable = true;
    nautilus.enable = true;
    fonts.enable = true;
    network.enable = true;
  };
}