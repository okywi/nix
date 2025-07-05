{ pkgs, config, lib, ... }:
with lib;
let 
  cfg = config.modules.niri;
in {
  imports = [
    ./niri.nix
  ];
  
  options.modules.niri = { enable = mkEnableOption "niri"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xwayland-satellite
      swww
      wlsunset
      hyprlock
    ];

    dconf = {
      settings = {
        "org/gnome/desktop/a11y/applications" = {
          screen-keyboard-enabled = true;
        };
      };
    };
  };
}
