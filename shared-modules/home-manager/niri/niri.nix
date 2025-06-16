{ pkgs, config, lib, monitors, ... }:
with lib;
let 
  cfg = config.modules.niri;

  getSecond = list:
    if builtins.length list < 2 then
      "null"
    else
      builtins.head (builtins.tail list);

  primary =
    builtins.elemAt (lib.splitString " " (builtins.elemAt monitors.niri 0)) 1;
  secondary = builtins.elemAt (lib.splitString " " (getSecond monitors.niri)) 1;

  configText = builtins.readFile ./config/config.kdl;
  outputsText = lib.concatStringsSep "\n" monitors.niri;
  inputText = builtins.readFile ./config/input.kdl;
  bindsText = builtins.readFile ./config/binds.kdl;
  appearanceText = builtins.readFile ./config/appearance.kdl;
  workspacesText = builtins.readFile ./config/workspaces.kdl;
  windowsText = builtins.readFile ./config/windows.kdl;
  startupText = builtins.readFile ./config/startup.kdl;

  combinedConfig = configText + "\n\n" + outputsText + "\n\n" + inputText + "\n\n" + bindsText + "\n\n" + appearanceText + "\n\n" + workspacesText + "\n\n" + windowsText + "\n\n" + startupText;

in {
  config = mkIf cfg.enable {

    xdg.configFile = {
      "niri/config.kdl".text = combinedConfig;
      "niri/hyprlock.conf".text = builtins.replaceStrings ["primaryMonitor"] ["${primary}"] (builtins.readFile ./hyprlock.conf);
      "niri/scripts".source = ./scripts;
    };
  };
}
