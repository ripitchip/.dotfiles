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
      name = "thomas";
      email = "thomas@example.com";
    };
  };
  home.packages = with pkgs; [
    lazygit
  ];
  xdg.configFile."lazygit/config.yml".source = ./config.yml;

}
