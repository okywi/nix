{ pkgs, inputs, ... }:
{
  ### Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  ### Programs
  programs.direnv.enable = true;
  services.locate.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

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
    jdk
    protonup

    # Applications
    inputs.zen-browser.packages."${system}".default
    librewolf
    bitwarden
    vesktop
    spotify
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

    # Gaming
    steam
    lutris

    # Launchers & Status Bars
    networkmanagerapplet
  ];
}
