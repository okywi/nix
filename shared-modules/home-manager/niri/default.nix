{ pkgs, config, lib, monitors, ... }:
with lib;
let 
  cfg = config.modules.niri;

  getSecond = list:
    if builtins.length list < 2 then
      "null"
    else
      builtins.head (builtins.tail list);

  primary =  builtins.elemAt (lib.splitString " " (builtins.elemAt monitors.niri 0)) 1;
  secondary = builtins.elemAt (lib.splitString " " (getSecond monitors.niri)) 1;
in {
  
  options.modules.niri = { enable = mkEnableOption "niri"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xwayland-satellite
      swww
      wlsunset
      hyprlock
      wvkbd
      hyprpicker
    ];

    xdg.configFile = {
      "niri/config.kdl".source = ./config.kdl;
      "niri/binds.kdl".source = ./binds.kdl;
      "niri/appearance.kdl".source = ./appearance.kdl;
      "niri/animations.kdl".source = ./animations.kdl;
      "niri/input.kdl".source = ./input.kdl;
      "niri/layout.kdl".source = ./layout.kdl;
      "niri/outputs.kdl".source = ./outputs.kdl;
      "niri/startup.kdl".source = ./startup.kdl;
      "niri/windows.kdl".source = ./windows.kdl;
      "niri/workspaces.kdl".source = ./workspaces.kdl;
      "niri/scripts".source = ./scripts;
      "niri/hyprlock.conf".text = builtins.replaceStrings ["\""] [""] (builtins.replaceStrings ["primaryMonitor"] ["${primary}"] (builtins.readFile ./hyprlock.conf));
    };
  };
}
