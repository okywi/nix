{ pkgs, config, lib, ... }:
with lib;
let 
  cfg = config.modules.sddm;
  customized_sddm_astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura";
    #themeConfig = {
    #  Background = "path/to/background.jpg"; # This theme also accepts videos
    #};2
  };
in {
  options.modules.sddm = { enable = mkEnableOption "sddm"; };

  config = mkIf cfg.enable {
    # Packages
    environment.systemPackages = with pkgs; [
      customized_sddm_astronaut
    ];

    # Service
    services.displayManager.sddm = lib.mkForce  {
      enable = true;
      wayland = {
        enable = true;
      };
      package = pkgs.kdePackages.sddm;
      extraPackages = with pkgs; [ 
        sddm-astronaut
      ];
      theme = "sddm-astronaut-theme";

    };

  };

}
