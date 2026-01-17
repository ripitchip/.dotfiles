{
  pkgs,
  ...
}:
{
  imports = [
    ./pulsemixer.nix
    ./flameshot.nix
    ./mpd.nix
  ];
  home.packages = with pkgs; [
    libreoffice
    vlc
    deezer-enhanced
  ];
}
