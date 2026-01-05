{ pkgs, ... }:

{
  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      serif = [ "CaskaydiaCove Nerd Font" ];
      monospace = [ "CaskaydiaCove Nerd Font Mono" ];
    };
  };

  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.caskaydia-mono
    nerd-fonts.caskaydia-cove
  ];
}
