{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
  ];
  xdg.configFile."nvim" = {
    source = ./nvim;
    onChange = "echo 'nvim config changed'";
  };
}
