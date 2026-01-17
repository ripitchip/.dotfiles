{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;
  cfg = config.my.desktop.hyprland;
in
{
  options.my.desktop.hyprland = {
    enable = mkEnableOption "Enable Hyprland desktop environment";
  };

  config = mkIf cfg.enable {
    # NixOS module - only enables Hyprland system-wide
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # Install required packages at system level
    environment.systemPackages = with pkgs; [
      kitty
      waybar
      wofi
      grim
      slurp
      wl-clipboard
      cliphist
      firefox
      hyprpicker
      hyprpaper
      xorg.xhost
    ];
    programs.thunar.enable = true;
  };
}
