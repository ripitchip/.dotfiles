{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    tmux
  ];
  xdg.configFile."tmux" = {
    source = ./tmux;
    onChange = "echo 'tmux config changed'";
  };
}
