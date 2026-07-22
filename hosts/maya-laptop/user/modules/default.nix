{ pkgs, ... }: {
  imports = [
    ./power.nix
    ./network.nix
  ];
}