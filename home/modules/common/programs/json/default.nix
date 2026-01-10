{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    vscode-json-languageserver
    prettier
  ];
}
