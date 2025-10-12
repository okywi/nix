{ pkgs, config, lib, ... }:

with lib;
let cfg = config.modules.audio;
in {
  options.modules.audio = { enable = mkEnableOption "audio"; };

  config = mkIf cfg.enable {
    # Packages
    environment.systemPackages = with pkgs; [ pulseaudio alsa-firmware ];

    # Pipewire
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      # pulse.enable = true;
      audio.enable = true;

      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
      wireplumber = {
        enable = true;

        /*configPackages = [
          (pkgs.writeTextDir
            "share/wireplumber/wireplumber.conf.d/alsa-soft-mixer.conf" ''
            monitor.alsa.rules = [
                {
                  matches = [
                    {
                      device.name = "alsa_card.pci-0000_c4_00.6"
                    }
                  ]
                  actions = {
                    update-props = {
                      # Do not use the hardware mixer for volume control. It
                      # will only use software volume. The mixer is still used
                      # to mute unused paths based on the selected port.
                      api.alsa.soft-mixer = true
                    }
                  }
                }
              ]
            '')
        ];*/
      };
    };

    # Bluetooth
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot =
      true; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true;
  };
}
