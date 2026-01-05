{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  home.stateVersion = "25.11";

  imports = [
    ./modules/shell.nix
    ./modules/common
    ./modules/desktop
  ];

  programs.home-manager.enable = true;

  # Only user packages go here
  home.packages = with pkgs; [
    neovim
    bat
    ripgrep
    fzf
  ];
}
