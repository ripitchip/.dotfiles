{ config, pkgs, lib, ... }:

{
  # NVIDIA closed-source
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
}

