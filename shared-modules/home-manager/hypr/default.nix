{ pkgs, config, lib, monitors, ... }:
with lib;
let
    cfg = config.modules.hyprland;
    username = config.home.username;

in {
    imports = [
        ./hyprland.nix
    ];

    options.modules.hyprland = { enable = lib.mkEnableOption "hyprland"; };

    config = mkIf cfg.enable {
        home.packages = with pkgs; [
          hyprpaper
          hyprland-autoname-workspaces
          hyprland-workspaces
          hyprlandPlugins.hyprgrass
          brightnessctl
          hyprpicker
          hyprshade
        ];

        # configuration
        # hyprland
        home.file.".config/hypr/hyprland" = {
          source = lib.cleanSourceWith {
            src = ./hyprland;
            filter = name: type:
              type != "regular"
              || !(lib.hasSuffix "workspaces.conf" (toString name));
          };
          recursive = true; # Important for directory copying
        };

      home.file.".config/hypr/hyprland/workspaces.conf".text = 
        if username == "okywi" then ''
          workspace=1, persistent:true, monitor:$primary
          workspace=2, persistent:true, monitor:$primary
          workspace=3, persistent:true, monitor:$primary
          workspace=4, persistent:true, monitor:$primary
          workspace=5, persistent:true, monitor:$primary
          workspace=6, persistent:true, monitor:$primary
          workspace=7, persistent:true, monitor:$secondary
          workspace=8, persistent:true, monitor:$secondary
          workspace=9, persistent:true, monitor:$secondary
          workspace=10, persistent:true, monitor:$secondary
        '' else if username == "okywi-laptop" then ''
          workspace=1, persistent:true, monitor:$primary
          workspace=2, persistent:true, monitor:$primary
          workspace=3, persistent:true, monitor:$primary
          workspace=4, persistent:true, monitor:$primary
          workspace=5, persistent:true, monitor:$primary
          workspace=6, persistent:true, monitor:$primary
          workspace=7, persistent:true, monitor:$primary
          workspace=8, persistent:true, monitor:$primary
          workspace=9, persistent:true, monitor:$primary
          workspace=10, persistent:true, monitor:$primary
        '' else
          '''';

        # assets
        home.file.".config/hypr/assets".source = ./assets;

        # scripts
        home.file.".config/hypr/scripts".source = ./scripts;

        # wallpapers
        home.file.".config/hypr/wallpapers".source = ./wallpapers;
        
        # hyprpaper
        home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;

        # hyprlock
        home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
    };
}