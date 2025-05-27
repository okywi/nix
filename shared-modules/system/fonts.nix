{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.fonts;
in {
  options.modules.fonts = { enable = mkEnableOption "fonts"; };

  config = mkIf cfg.enable {
    ### Fonts
    fonts.packages = with pkgs; [
      font-awesome
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
      nerd-fonts.meslo-lg
      nerd-fonts.ubuntu-mono
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.roboto-mono
      nerd-fonts.droid-sans-mono
      font-awesome_5
      noto-fonts
      icomoon-feather
    ];
  };
}
