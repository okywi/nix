{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.git;
in {
  options.modules.git = { enable = mkEnableOption "git"; };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      package = pkgs.git;
      settings = {
        user = {
          name = "okywi";
          email = "m.laupheimer@protonmail.com";
        };
      };
    };
  };
}
