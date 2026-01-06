{
  pkgs,
  lib,
  config,
  ...
}:
{

  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs (old: {
    src = ./dwm;
    buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.libxcb ];
  });
  environment.systemPackages = with pkgs; [
    dmenu
    xclip
    clipmenu
    dwmblocks
    feh
    picom
    autorandr
    dunst
  ];
}
