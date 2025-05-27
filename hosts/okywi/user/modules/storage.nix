{ pkgs, config, lib, inputs, ... }:
with lib;
let cfg = config.modules.storage;
in {
  options.modules.storage = { enable = mkEnableOption "storage"; };

  config = mkIf cfg.enable {
    fileSystems."/" =
    { device = "/dev/disk/by-uuid/8294f943-168b-4e54-a0d0-7f3f4eea3398";
      fsType = "ext4";
      options = [ "defaults" "x-gvfs-show" ];
    };

    fileSystems."/mnt/games" =
    { device = "/dev/disk/by-uuid/649c5ccc-f498-41b6-b661-de1dd6acc219";
      fsType = "ext4";
      options = [ "defaults" "x-gvfs-show" ];
    };

    fileSystems."/mnt/windows" =
    { device = "/dev/disk/by-uuid/1812B31004366418";
      fsType = "ntfs";
      options = [ "defaults" "x-gvfs-show" ];
    };
  };
}
