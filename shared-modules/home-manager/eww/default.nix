{ pkgs, config, lib, username, ... }:
with lib;
let
  cfg = config.modules.eww;
  eww_yuck = "${builtins.readFile ./eww.yuck}";
  eww_style = "${builtins.readFile ./eww.scss}";

  # define workspaces for each machine
  hypr_workspaces = if username == "okywi" then ''
    [0]="     "
          [1]="   "'' else if username == "okywi-laptop" then
    ''[0]="         "''
  else
    ''[0]=""'';
  sway_workspaces = if username == "okywi" then
    ''icons=("" "" "" "" "" "" "" "" "" "")''
  else if username == "okywi-laptop" then
    ''icons=("" "" "" "" "" "" "" "" "" "")''
  else
    "icons=()";
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
        # Important for directory copying
        ".config/eww/styles".source = ./styles;
        ".config/eww/yuck".source = ./yuck;
        ".config/eww/launch_eww.sh".source = ./launch_eww.sh;
      }
    ];
  };
}
