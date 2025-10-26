{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.fish;
in {
  options.modules.fish = { enable = mkEnableOption "fish"; };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      generateCompletions = true;
      shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake ~/nixos";
      };

      shellInit = "fastfetch --logo ~/.config/fastfetch/ascii";
    };
  };
}
