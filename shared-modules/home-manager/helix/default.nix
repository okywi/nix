{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.helix;
in
{
  options.modules.helix = {
    enable = mkEnableOption "helix";
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      settings = {
        theme = "catppuccin_mocha";
        editor.cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      languages.language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.nixfmt;
        }
        {
          name = "latex";
          auto-format = true;
          formatter.command = "${pkgs.tex-fmt}/bin/tex-fmt";
        }
      ];
      languages.language-server.texlab = {
      config = {
        texlab.chktex = {
          onOpenAndSave = true;
          onEdit = true;
        };
        texlab.forwardSearch = {
          executable = "zathura";
          args = [
            "--synctex-forward"
            "%l:%c:%f"
            "%p"
          ];
        };
        texlab.build = {
          auxDirectory = "build";
          logDirectory = "build";
          pdfDirectory = "build";
          forwardSearchAfter = true;
          onSave = true;
          executable = "tectonic";
          args = [
            "-X"
            "compile"
            "--synctex"
            "--keep-logs"
            "--keep-intermediates"
            "--outdir=build"
            "%f"
          ];
        };
      };
    };
      themes = {
        autumn_night_transparent = {
          "inherits" = "autumn_night";
          "ui.background" = { };
        };
      };
    };
  };
}
