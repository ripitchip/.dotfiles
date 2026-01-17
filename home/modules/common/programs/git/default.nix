{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "ripitchip";
      email = "thomas@foobarbaz.fr";
    };
  };
  home.packages = with pkgs; [
    lazygit
  ];
  xdg.configFile."lazygit/config.yml".source = ./config.yml;

}
