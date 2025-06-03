{ pkgs, inputs, ... }:
let
  androidSdk = pkgs.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "latest";
    platformVersions = [ "34" ];
    buildToolsVersions = [ "34.0.0" ];
  };
in {
  ### Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  ### Programs
  programs.direnv.enable = true;
  services.locate.enable = true;
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    gamescopeSession.enable = true;
  };

  services.udev.packages = [
    pkgs.android-udev-rules
  ];
  # Required for AAPT2 to work
  programs.nix-ld.enable = true;

  # for android sdk
  nixpkgs.config.android_sdk.accept_license = true;

  ### System Packages
  environment.systemPackages = with pkgs; [
    # Libraries
    glib

    # Terminal
    neovim
    bash
    nixfmt-classic

    # Utilities
    home-manager
    wget
    btop
    findutils
    killall
    playerctl
    zscroll
    mangohud
    jq
    unzip
    pciutils
    wl-clipboard
    xdg-user-dirs
    libnotify
    procps
    dua
    bc
    tree
    rnote

    # Applications
    inputs.zen-browser.packages."${system}".default
    librewolf
    bitwarden
    vesktop
    spotify
    spotify-tray
    copyq
    vscodium
    signal-desktop
    electron-mail
    zapzap
    nwg-look
    loupe
    localsend
    pinta
    kdePackages.kdenlive
    mpv
    cheese
    gnome-disk-utility
    baobab
    pavucontrol
    libreoffice
    obsidian
    prismlauncher
    heroic

    # Programming
    jdk
    jetbrains.idea-community-bin
    jetbrains.pycharm-community
    android-tools
    androidSdk.androidsdk

    # Gaming
    lutris

    # Launchers & Status Bars
    networkmanagerapplet
  ];

  # env variables for programs
  environment.sessionVariables = {
    ANDROID_HOME = "${androidSdk.androidsdk}/libexec/android-sdk";
  };
}
