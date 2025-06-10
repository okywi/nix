{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.modules.eww;
  eww_yuck = "${builtins.readFile ./eww.yuck}";
  eww_style = "${builtins.readFile ./eww.scss}";

  hypr_workspaces = config.my.eww.hypr_workspaces;
  sway_workspaces = config.my.eww.sway_workspaces;
  left_widgets = config.my.eww.left_widgets;
  right_widgets = config.my.eww.right_widgets;
    
in {
  options.modules.eww = { enable = mkEnableOption "eww"; };

  config = mkIf cfg.enable {
    # eww package
    home.packages = with pkgs; [ eww pamixer brightnessctl ];

    home.file = mkMerge [
      (mkIf config.modules.hyprland.enable {
        ".config/eww/eww.yuck".text =
          builtins.replaceStrings [ "session" ] [ "hypr" ] eww_yuck;
        ".config/eww/eww.scss".text =
          builtins.replaceStrings [ "session" ] [ "hypr" ] eww_style;
        ".config/eww/scripts/hypr/workspaces.sh" = {
          text =
            builtins.replaceStrings [ "input_workspaces" ] [ hypr_workspaces ]
            (builtins.readFile ./scripts/hypr/workspaces.sh);
          executable = true;
        };
      })
      (mkIf config.modules.sway.enable {
        ".config/eww/eww.yuck".text =
          builtins.replaceStrings [ "session" ] [ "sway" ] eww_yuck;
        ".config/eww/eww.scss".text =
          builtins.replaceStrings [ "session" ] [ "sway" ] eww_style;
        ".config/eww/scripts/sway/workspaces.sh" = {
          text =
            builtins.replaceStrings [ "input_workspaces" ] [ sway_workspaces ]
            (builtins.readFile ./scripts/sway/workspaces.sh);
          executable = true;
        };
      })

      # set widgets per host
      {".config/eww/yuck/bar.yuck".text = pkgs.lib.replaceStrings 
      [ "config_left_widgets" "config_right_widgets" ] [ left_widgets right_widgets ]
      (builtins.readFile ./yuck/bar.yuck);
      }
      # flsdjf
      {
        # exclude workspaces.sh
        ".config/eww/scripts" = {
          source = lib.cleanSourceWith {
            src = ./scripts;
            filter = name: type:
              type != "regular"
              || !(lib.hasSuffix "workspaces.sh" (toString name));
          };
          recursive = true; # Important for directory copying
        };

        ".config/eww/yuck" = {
          source = lib.cleanSourceWith {
            src = ./yuck;
            filter = name: type:
              type != "regular"
              || !(lib.hasSuffix "bar.yuck" (toString name));
          };
          recursive = true; # Important for directory copying
        };
        ".config/eww/styles".source = ./styles;
        ".config/eww/launch_eww.sh".source = ./launch_eww.sh;
        ".config/eww/assets".source = ./assets;
      }
    ];
  };
}
