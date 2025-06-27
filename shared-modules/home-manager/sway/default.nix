{ pkgs, config, lib, programs, monitors, ... }:
with lib;
let
    cfg = config.modules.sway;
in {
    imports = [
        ./sway.nix
    ];

    options.modules.sway = { enable = lib.mkEnableOption "sway"; };

    config = mkIf cfg.enable {
        # packages
        home.packages = with pkgs; [
            swaybg
            brightnessctl
            swww
        ];

        # configuration
        home.file = {
            ".config/sway/scripts".source = ./scripts;
            ".config/sway/conf/outputs".text = builtins.concatStringsSep "\n" monitors.sway + "\n" + ''
                output * max_render_time 5
                output * adaptive_sync on
                output * subpixel rgb
            '';
            ".config/sway/conf/variables".source = ./conf/variables;
            ".config/sway/conf/appearance".source = ./conf/appearance;
            ".config/sway/conf/autostart".source = ./conf/autostart;
            ".config/sway/conf/bindings".source = ./conf/bindings;
            ".config/sway/conf/inputs".source = ./conf/inputs;
            ".config/sway/conf/windows".source = ./conf/windows;
            ".config/sway/conf/workspaces".source = ./conf/workspaces;
        };
    };
}