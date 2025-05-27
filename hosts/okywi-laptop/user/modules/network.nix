{ pkgs, config, lib, inputs, username, ... }:
with lib;
let cfg = config.modules.network;
in {
  options.modules.network = { enable = mkEnableOption "network"; };

  config = mkIf cfg.enable {
    ### Networking
    networking.hostName = username; # Define your hostname.
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Enable the OpenSSH daemon
    services.openssh.enable = true;

    # Open ports in the firewall.
    # localsend, 
    networking.firewall.allowedTCPPorts = [ 53317 ];
    networking.firewall.allowedUDPPorts = [ 53317 ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };
}
