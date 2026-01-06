{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix

    # Core modules
    ./modules/nix.nix
    ./modules/networking.nix
    ./modules/common
    ./modules/audio.nix
    ./modules/shell.nix
    ./users.nix

    # Bootloader & system basics
    ./modules/bootloader.nix
    ./modules/locale.nix
    ./modules/virtualisation

    # Graphics
    ./modules/graphics.nix

    ./modules/bluetooth.nix
    ./modules/xrdp.nix

    # Desktop modules
    ./modules/desktop
    # ./modules/desktop/niri
  ];

  environment.systemPackages = with pkgs; [
    vim
  ];

  system.stateVersion = "25.11";
}
