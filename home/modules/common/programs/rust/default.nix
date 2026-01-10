{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    webkitgtk_4_1
    rustup
  ];
}
