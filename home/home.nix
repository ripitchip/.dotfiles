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

  # Make Electron apps (like VS Code) prefer Wayland
  home.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto"; # switch to "wayland" to force Wayland
  };

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

  # Add a Wayland-specific VS Code launcher
  xdg.desktopEntries."code-wayland" = {
    name = "Visual Studio Code (Wayland)";
    genericName = "Code Editor";
    comment = "VS Code using Wayland Ozone platform";
    exec = "env ELECTRON_OZONE_PLATFORM_HINT=wayland code --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland";
    icon = "visual-studio-code";
    type = "Application";
    terminal = false;
    categories = [
      "Development"
      "IDE"
    ];
  };
}
