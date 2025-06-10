{ pkgs, config, lib, inputs, ... }:
with lib;
let cfg = config.modules.userPackages;
in {
  options.modules.userPackages = { enable = mkEnableOption "userPackages"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        lact
      ];
    systemd.packages = with pkgs; [ lact ];
    systemd.services.lactd.wantedBy = ["multi-user.target"];

    programs.alvr = {
      enable = true;
      openFirewall = true;
    };
  };
}
