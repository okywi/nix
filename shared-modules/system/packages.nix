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
  programs.dconf.enable = true;
  services.locate.enable = true;
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    gamescopeSession.enable = true;
  };

    services.iptsd = {
    enable = true;
    config = {
      Touchscreen.DisableOnPalm = false;
      Touchscreen.DisableOnStylus = true;
    };
  };

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  services.saned.enable = true;

  hardware.sane.enable = true;

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
    usbutils
    caligula # burn usb's cli
    socat
    gsettings-desktop-schemas
    acpi # battery
    qbittorrent
    cups-filters

    # Applications
    inputs.zen-browser.packages."${system}".default
    inputs.hytale-launcher.packages.${system}.default
    librewolf
    bitwarden-desktop
    vesktop
    spotify
    copyq
    vscodium
    signal-desktop
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
    kdePackages.kdeconnect-kde
    ausweisapp
    chromium
    dconf-editor
    osu-lazer
    opentabletdriver
    watchmate
    pkg-config
    gnome-calculator
    mullvad-browser
    xournalpp
    vlc
    simple-scan
    


    ### Programming
    jdk
    jetbrains.idea-community-bin
    jetbrains.pycharm-community
    android-tools
    androidSdk.androidsdk
    go
    glfw
    libGL
    xorg.libX11
    xorg.libXcursor
    xorg.libXext
    xorg.libXrandr
    xorg.libXxf86vm
    nodejs
    mqttx
    docker
    arduino-ide

    # rust
    rustup
    cargo
    gcc
    rustfmt

    # Gaming
    lutris

    # Launchers & Status Bars
    networkmanagerapplet
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
      "org.libreoffice.LibreOffice"
    ];
  };
}
