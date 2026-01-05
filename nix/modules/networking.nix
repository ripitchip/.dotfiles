{ config, lib, ... }:

{
  options.my.networking.enable =
    lib.mkEnableOption "basic networking";

  config = lib.mkIf config.my.networking.enable {
    networking.networkmanager.enable = true;
  };
}

