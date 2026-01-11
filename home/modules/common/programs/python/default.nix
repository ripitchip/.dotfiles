{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    python313
    python313Packages.virtualenv
  ];
}
