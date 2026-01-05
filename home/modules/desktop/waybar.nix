{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;

  };
  home.packages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    adwaita-icon-theme
    xorg.xbacklight
  ];
  xdg.configFile."waybar/config.jsonc".source = ./waybar/config.jsonc;
  xdg.configFile."waybar/modules.jsonc".source = ./waybar/modules.jsonc;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;
  xdg.configFile."waybar/css/style.css".source = ./waybar/css/style.css;
  xdg.configFile."waybar/css/colors.css".source = ./waybar/css/colors.css;
  xdg.configFile."waybar/layouts/with_music.jsonc".source = ./waybar/layouts/with_music.jsonc;
  xdg.configFile."waybar/context/ctlcenter.xml".source = ./waybar/context/ctlcenter.xml;
  xdg.configFile."waybar/context/network.xml".source = ./waybar/context/network.xml;

}
