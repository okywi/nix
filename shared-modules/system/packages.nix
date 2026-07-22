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

  nixpkgs.config.permittedInsecurePackages = [
       "electron-39.8.10"
       "pnpm-10.29.2"
    ];
  
  ### Enable Lix
  nixpkgs.overlays = [ (final: prev: {
    inherit (prev.lixPackageSets.stable)
      nixpkgs-review
      nix-eval-jobs
      nix-fast-build
      colmena;
  }) ];

  nix.package = pkgs.lixPackageSets.stable.lix;

  ### Programs
  programs.direnv.enable = true;
  programs.dconf.enable = true;
  services.locate.enable = true;
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    gamescopeSession.enable = true;
  };
  programs.kdeconnect.enable = true;
  programs.ausweisapp = {
    enable = true;
    openFirewall = true;
  };


  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };


  services.saned.enable = true;

  hardware.sane.enable = true;
  hardware.opentabletdriver.enable = true;
  hardware.uinput.enable = true;

  virtualisation.docker.enable = true;
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
    nixfmt

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
    usbutils
    caligula # burn usb's cli
    socat
    gsettings-desktop-schemas
    acpi # battery
    qbittorrent
    cups-filters

    # Applications
    inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
    pear-desktop
    #kdePackages.audiotube
    inputs.hytale-launcher.packages.${stdenv.hostPlatform.system}.default
    librewolf
    bitwarden-desktop
    vesktop
    labymod-launcher
    copyq
    vscodium
    zapzap
    element-desktop
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
    obsidian
    prismlauncher
    heroic
    gnome-themes-extra
    adwaita-icon-theme
    krita
    libresprite
    obs-studio
    ffmpeg
    squeekboard
    gnome-font-viewer
    calibre
    chromium
    dconf-editor
    watchmate
    pkg-config
    gnome-calculator
    mullvad-browser
    xournalpp
    vlc
    simple-scan
    gnome-clocks
    gnome-sound-recorder
    audacity
    friture
    libreoffice-fresh

    ### Programming
    jdk
    jetbrains.idea-oss
    jetbrains.pycharm-oss
    android-tools
    androidSdk.androidsdk
    go
    glfw
    libGL
    libx11
    libxcursor
    libxext
    libxrandr
    libxxf86vm
    nodejs
    mqttx
    arduino-ide
    python3

    # rust
    rustup
    cargo
    gcc
    rustfmt

    # Gaming
    lutris
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin


    # Launchers & Status Bars
    networkmanagerapplet
    iwgtk
  ];

  # env variables for programs
  environment.sessionVariables = {
    ANDROID_HOME = "${androidSdk.androidsdk}/libexec/android-sdk";
    FLATPAK_OVERRIDE_GTK_THEME = "Adwaita-dark";
  };

  ### FLATPAKS
  services.flatpak = {
    enable = true;
    packages = [
      "com.github.flxzt.rnote"
      "org.vinegarhq.Sober"
    ];
  };
}
