{
  pkgs,
  pkgs-zen-browser,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser.enable = true;
}
