{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    yaml-language-server
    prettier
  ];
}
