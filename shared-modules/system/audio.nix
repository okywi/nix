{ pkgs, config, lib, ... }:

with lib;
let cfg = config.modules.audio;
in {
  options.modules.audio = { enable = mkEnableOption "audio"; };

  config = mkIf cfg.enable {
    # Packages
    environment.systemPackages = with pkgs; [
      pulseaudio
      wireplumber
      alsa-firmware
    ];

    # Pipewire
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };

    # Bluetooth
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true;
  };
}
