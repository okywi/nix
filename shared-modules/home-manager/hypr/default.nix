{ pkgs, config, lib, monitors, ... }:
with lib;
let
    cfg = config.modules.hyprland;
    workspaces = config.my.workspaces.hyprland;
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
          wlsunset
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

        home.file.".config/hypr/hyprland/workspaces.conf".text = workspaces;

        # assets
        home.file.".config/hypr/assets".source = ./assets;

        # scripts
        home.file.".config/hypr/scripts".source = ./scripts;

        # hyprpaper
        home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;

        # hyprlock
        home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
    };
}