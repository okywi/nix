{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.nautilus;
in {
  options.modules.nautilus = { enable = mkEnableOption "nautilus"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ nautilus ];

    # nautilus file system support
    services.gvfs.enable = true;

    ## setup xdg dirs so they are correctly displayed in nautilus
    system.userActivationScripts.setupXdgDirs = ''
      mkdir -p ~/Documents ~/Downloads ~/Pictures ~/Videos ~/Music
      ${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update
    '';

    services.dbus.packages = [ pkgs.gcr ]; # For GNOME keyring/bookmarks
    #environment.pathsToLink = [ "/libexec" ]; # Needed for some GNOME apps
  };
}
