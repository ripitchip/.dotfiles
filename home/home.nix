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
    createDirectories = true;
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

  # Dark theme defaults for GTK & Qt
  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk"; # make Qt follow GTK portal/theme where possible
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark"; # Adwaita-qt style name
    };
  };

  # Only user packages go here
  home.packages = with pkgs; [
    neovim
    bat
    ripgrep
    fzf
    kdePackages.okular
  ];
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*"; # Ensures GTK handles the print dialog
  };
}
