{ config, lib, pkgs, ... }:

{
  options.my.audio.enable =
    lib.mkEnableOption "PipeWire audio";

  config = lib.mkIf config.my.audio.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };
}

