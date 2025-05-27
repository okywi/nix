{ pkgs, ... }: {
  imports = [
    ./power.nix
    ./network.nix
    ./storage.nix
  ];
}