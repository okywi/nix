{ pkgs, ... }: {
  imports = [
    ./storage.nix
    ./power.nix
    ./network.nix
  ];
}