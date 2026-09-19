{ pkgs, config, lib, inputs, ... }:
with lib;
let 
  cfg = config.modules.nvim;
in {
  imports = [
    		inputs.lazyvim.homeManagerModules.default

  ];

  options.modules.nvim = { enable = mkEnableOption "nvim"; };
  
  config = mkIf cfg.enable {
    programs.lazyvim.enable = true;

    xdg.configFile."nvim/lua/plugins/latex.lua".source = ./plugins/latex.lua;
  };

    
}
