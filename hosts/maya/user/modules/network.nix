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
      # dns = "none";
      wifi = {
        powersave = false;
      };
    };
    # These options are unnecessary when managing DNS ourselves
    networking.useDHCP = false;
    networking.dhcpcd.enable = false;
    
    #boot.kernel.sysctl."net.ipv6.conf.wlp5s0.disable_ipv6" = true;
    /*services.doh-server.enable = true;
    services.dnscrypt-proxy2 = {
      enable = true;
    };
    networking.resolvconf.enable = true;
    networking.nameservers = [ "9.9.9.9" "149.112.112.112" "2620:fe::fe" "2620:fe::9" ];
   */

 /* services.dnscrypt-proxy = {
    enable = true;
    settings = {
      # Server selection
      # "cloudflare" is a good default, but you can choose from:
      # https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      server_names = [ "quad9-dnscrypt-ip4-filter-pri" ];

      # Privacy and Security
      require_dnssec = true;
      require_nolog = true;
      require_nofilter = false; # Set to false if you want ad-blocking
      
      # Network
      # Set to false if you don't have IPv6, to avoid connection issues.
      ipv6_servers = false;
      block_ipv6 = true;
    };
  };*/
    # Change anything here and have fun going insane debugging issues with no documentation.
    #services.resolved.enable = false;
    networking.networkmanager.dns = "none";
    networking.nameservers = [ "9.9.9.9" "149.112.112.112" "2620:fe::fe" "2620:fe::9" ];
    networking.enableIPv6 = true;

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
