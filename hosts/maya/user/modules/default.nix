{ pkgs, ... }: {
  imports = [
    ./power.nix
    ./network.nix
    ./packages.nix
  ];
}