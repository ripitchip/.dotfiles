{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bambu-studio
    orca-slicer
    freecad
    rpi-imager
  ];
}
