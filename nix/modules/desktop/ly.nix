{ config, lib, ... }:

{
  options.my.desktop.ly.enable =
    lib.mkEnableOption "Ly display manager";

  config = lib.mkIf config.my.desktop.ly.enable {
    services.displayManager.ly = {
      enable = true;
      settings.clock = true;
    };
  };
}

