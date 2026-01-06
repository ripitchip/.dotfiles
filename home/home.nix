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
    ./modules/common
    ./modules/desktop
  ];

  # XDG directory configuration
  xdg.userDirs = {
    enable = true;
    desktop = "${config.home.homeDirectory}/desktop";
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/downloads";
    music = "${config.home.homeDirectory}/music";
    pictures = "${config.home.homeDirectory}/images";
    videos = "${config.home.homeDirectory}/videos";
    publicShare = "${config.home.homeDirectory}/public";
    templates = "${config.home.homeDirectory}/.templates";
  };

  programs.home-manager.enable = true;

  # Only user packages go here
  home.packages = with pkgs; [
    neovim
    bat
    ripgrep
    fzf
  ];
}
