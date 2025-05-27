{ pkgs, config, lib, inputs, ... }:
with lib;
let cfg = config.modules.storage;
in {
  options.modules.storage = { enable = mkEnableOption "storage"; };

  config = mkIf cfg.enable {
    fileSystems."/" =
    { device = "/dev/disk/by-uuid/42d8f68c-6bfa-43ed-92a7-97f53a68e92b";
      fsType = "ext4";
      options = [ "defaults" "x-gvfs-show" ];
    };
  };
}
