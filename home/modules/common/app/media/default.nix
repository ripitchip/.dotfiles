{
  pkgs,
  ...
}:
{
  imports = [
    ./pulsemixer.nix
    ./flameshot.nix
  ];
  home.packages = with pkgs; [
    libreoffice
    vlc
  ];
}
