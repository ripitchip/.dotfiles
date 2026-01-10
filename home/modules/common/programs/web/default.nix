{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    pnpm
    vue
    yarn
  ];
}
