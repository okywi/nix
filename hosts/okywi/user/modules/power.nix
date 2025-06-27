{ pkgs, config, lib, inputs, ... }:
with lib;
let cfg = config.modules.power;
in {
  options.modules.power = { enable = mkEnableOption "power"; };

  config = mkIf cfg.enable {
        environment.systemPackages = with pkgs;
      [
        lact
      ];
    systemd.packages = with pkgs; [ lact ];
    systemd.services.lactd.wantedBy = ["multi-user.target"];
    systemd.services.cpufreq.enable = false;

    services = {
      power-profiles-daemon.enable = false;
      thermald.enable = false;
      tlp.enable = false;
      cpupower-gui.enable = false;
      
    };
    powerManagement = {
      enable = true;
      cpuFreqGovernor = "schedutil";
      powerUpCommands = ''
        echo "balance_performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
      '';
    };
  };
}