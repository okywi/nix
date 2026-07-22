{ pkgs, config, lib, inputs, ... }:
with lib;
let cfg = config.modules.network;
in {
  options.modules.network = { enable = mkEnableOption "network"; };

  config = mkIf cfg.enable {

    ### Networking
    networking.hostName = "maya-pc"; # Define your hostname.
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    networking.hosts = {
      "0.0.0.0" = [ "paradise-s1.battleye.com" "test-s1.battleye.com" "paradiseenhanced-s1.battleye.com" ];
    };
    
    # Enable networking
    networking.networkmanager = {
      enable = true;
      wifi = {
        powersave = false;
      };
    };

    boot.kernel.sysctl."net.ipv6.conf.wlan0.disable_ipv6" = true;

    networking.nameservers = [ "9.9.9.9" "149.112.112.112" "1.1.1.1" "8.8.8.8" ];
    networking.enableIPv6 = false;
    
    # Enable the OpenSSH daemon
    services.openssh.enable = true;

    # Open ports in the firewall.
    # localsend, 
    networking.firewall.allowedTCPPorts = [ 53317 5353 8611 8612 9100 631  ];
    networking.firewall.allowedTCPPortRanges = [
      {
        from  = 1714;
        to = 1764;
      }
    ];
    networking.firewall.allowedUDPPorts = [ 53317 5353 8611 8612 9100 631  ];
     networking.firewall.allowedUDPPortRanges = [
      {
        from  = 1714;
        to = 1764;
      }
    ];
    # Or disable the firewall altogether.
    networking.firewall.enable = true;
  };
}
