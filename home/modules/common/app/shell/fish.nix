{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };
  xdg.configFile."fish/functions/fish_prompt.fish".source = ./fish_prompt.fish;
}
