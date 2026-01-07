{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    python314
    python314Packages.virtualenv
  ];
}
