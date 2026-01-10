{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    lua
    lua51
    lua51Packages.luarocks
    lua51Packages.lua
  ];
}
