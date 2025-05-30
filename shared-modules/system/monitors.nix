{ lib, ... }:

let

in {
  options.my.monitors = lib.mkOption {
    type = lib.types.attrsOf (lib.types.listOf lib.types.str);
    default = {};
    example = lib.literalExpression ''
      {
        hyprland = [ "DP-1,2560x1440@144,0x0,1" ];
        sway = [ "eDP-1 res 1920x1080 pos 0,0" ];
      }
    '';
    description = ''
      Monitor configurations for different Wayland compositors.
      Format must match the expected syntax for each compositor:
      - Hyprland: "NAME,RESOLUTION@RATE,POSITION,SCALE"
      - Sway: "NAME res WxH[@RATE] pos X,Y [scale FACTOR]"
    '';
  };
}