{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hyprland.nix
  ];

  my.desktop.hyprland.enable = true;
}
