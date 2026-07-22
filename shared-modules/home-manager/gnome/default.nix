{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.modules.gnome;
  mkTuple = lib.hm.gvariant.mkTuple;
in {

  options.modules.gnome = { enable = mkEnableOption "gnome"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        dracula-theme
        gnomeExtensions.dash-to-dock
        gnomeExtensions.blur-my-shell
        gnomeExtensions.user-themes
        gnomeExtensions.gjs-osk
        gnomeExtensions.appindicator
        gnomeExtensions.auto-move-windows
        gnomeExtensions.places-status-indicator
        gnomeExtensions.system-monitor
      ];

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/input-sources" = {
          sources = [ (mkTuple [ "xkb" "us+altgr-intl" ]) ];
          xkb-options = [ ];
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
          {
            name = "kitty super";
            command = "kitty";
            binding = "<Super>Return";
          };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" =
          {
            name = "file manager";
            command = "nautilus";
            binding = "<Super>E";
          };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" =
          {
            name = "config";
            command = "codium nixos";
            binding = "<Super><Alt><Ctrl>C";
          };
        "org/gnome/desktop/wm/keybindings" = {
          toggle-maximized = [ "<Super>F" ];
          toggle-fullscreen = [ "<Super><Shift>F" ];
          close = [ "<Super>W" ];
          switch-to-workspace-1 = [ "<Super>1" ];
          switch-to-workspace-2 = [ "<Super>2" ];
          switch-to-workspace-3 = [ "<Super>3" ];
          switch-to-workspace-4 = [ "<Super>4" ];
          switch-to-workspace-5 = [ "<Super>5" ];
          switch-to-workspace-6 = [ "<Super>6" ];
        };
        "org/gnome/shell/keybindings" = {
          show-screenshot-ui = [ "<Super><Shift>S" ];
          switch-to-application-1 = [ "" ];
          switch-to-application-2 = [ "" ];
          switch-to-application-3 = [ "" ];
          switch-to-application-4 = [ "" ];
          switch-to-application-5 = [ "" ];
          switch-to-application-6 = [ "" ];
          switch-to-application-7 = [ "" ];
          switch-to-application-8 = [ "" ];
          switch-to-application-9 = [ "" ];
        };
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions =  with pkgs.gnomeExtensions; [
            #pkgs.gnomeExtensions.tiling-shell.extensionUuid
            #pkgs.gnomeExtensions.forge.extensionUuid
            #pkgs.gnomeExtensions.im-panel-integrated-with-osk.extensionUuid
            auto-move-windows.extensionUuid
            places-status-indicator.extensionUuid
            system-monitor.extensionUuid
            dash-to-dock.extensionUuid
            user-themes.extensionUuid
            blur-my-shell.extensionUuid
            gjs-osk.extensionUuid
            appindicator.extensionUuid
          ];
          favorite-apps = [
            "zen-beta.desktop"
            "org.gnome.Nautilus.desktop"
            "org.gnome.Calendar.desktop"
            "com.github.flxzt.rnote.desktop"
            "spotify.desktop"
            "steam.desktop"
            "com.rtosta.zapzap.desktop"
            "signal.desktop"
            "org.gnome.Settings.desktop"
          ];
        };
        "org/gnome/shell/extensions/user-theme" = {
          name = "Dracula"; # Replace with your exact theme folder name
        };
        "org/gnome/shell/extensions/system-monitor" = {
          show-cpu = true;
          show-memory = true;
        };
        "org/gnome/shell/extensions/gjsosk" = {
          font-size-px = 16;
          font-bold = true;
          landscape-width-percent = 90;
          landscape-height-percent = 45;
          round-key-corners = true;
          system-accent-col = true;
        };
        "org/gnome/shell/extensions/gjsosk/indicator" = {
          keyboard-visible = true;
        };
        "org/gnome/desktop/a11y/applications" = {
          screen-keyboard-enabled = false;
        };
        "org/gnome/shell/extensions/tilingshell" = {
          inner-gaps = 0;
          outer-gaps = 0;
          top-edge-maximize = true;
          show-indicator = true;
        };
        "org/gnome/mutter" = {
          experimental-features = [
            "scale-monitor-framebuffer" # Enables fractional scaling (125% 150% 175%)
            "variable-refresh-rate" # Enables Variable Refresh Rate (VRR) on compatible displays
            "xwayland-native-scaling" # Scales Xwayland applications to look crisp on HiDPI screens
          ];
        };
        "org/gnome/shell/extensions/dash-to-dock" = {
          always-center-icons = true;
          dash-max-icon-size = 56;
          disable-overview-on-startup = true;
          dock-fixed = false;
          dock-positon = "BOTTOM";
          extend-height = false;
          height-fraction = 0.9;
          hot-keys = false;
          icon-size-fixed = false;
          isolate-monitors = false;
          isolate-workspaces = true;
          scroll-to-focused-application = true;
          show-apps-at-top = false;
          show-favorites = true;
          show-mounts = false;
          show-mounts-network = false;
          show-mounts-only-mounted = true;
          show-running = true;
          transparency-mode = "DEFAULT";
          application-list = [
            "steam.desktop:4"
            "com.rtosta.zapzap.desktop:6"
            "signal.desktop:6"
            "vesktop.desktop:6"
            "spotify.desktop:5"
            "electron-mail.desktop:6"
          ];
        };
      };
    };
  };
}
