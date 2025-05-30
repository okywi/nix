{ lib, ... }:
with lib;
let
in {
  # Workspaces string for WMs
  options.my.workspaces = lib.mkOption {
    type = lib.types.attrsOf (lib.types.str);
    default = {};
  };

  # Input
  options.my.input = lib.mkOption {
    type = lib.types.attrsOf (lib.types.oneOf [
      lib.types.str
      lib.types.int
      lib.types.bool
    ]);
    default = {};
  };

  # eww
  # Input
  options.my.eww = lib.mkOption {
    type = lib.types.attrsOf (lib.types.oneOf [
      lib.types.str
    ]);
    default = {};
  };
}