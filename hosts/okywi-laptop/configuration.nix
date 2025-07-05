# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
with lib; {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./user/user.nix
  ];

  ### Bootloader.
  boot.loader = {
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      devices = [ "nodev" ];
      theme = pkgs.catppuccin-grub;
    };
  };
  boot.kernelParams = [ "amdgpu" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  ### Locale
  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "de";

  # X Server
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };

  ### Hardware
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  ### Printing
  services.printing = {
    enable = true;
    browsing = false;
    drivers = with pkgs; [
      gutenprint
      cnijfilter2
      cups-bjnp
    ];
  };
  # for printer browsing
  services.avahi = {
    enable = false;
    nssmdns4 = true;
    openFirewall = true;
  };

  ### garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  ### Features
  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # 
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
