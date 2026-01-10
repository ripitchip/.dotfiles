{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    lazydocker
    dockerfile-language-server
  ];
}
