{ pkgs, config, lib, inputs, ... }:
with lib;
let cfg = config.modules.network;
in {
  options.modules.network = { enable = mkEnableOption "network"; };

  config = mkIf cfg.enable {
    ### Networking
    networking.hostName = "okywi-laptop"; # Define your hostname.
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Enable the OpenSSH daemon
    services.openssh.enable = true;

    # Open ports in the firewall.
    # localsend, 
    networking.firewall.allowedTCPPorts = [ 53317 24727 ];
    networking.firewall.allowedTCPPortRanges = [
      {
        from  = 1714;
        to = 1764;
      }
    ];
    networking.firewall.allowedUDPPorts = [ 53317 24727 ];
    networking.firewall.allowedUDPPortRanges = [
      {
        from  = 1714;
        to = 1764;
      }
    ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };
}
