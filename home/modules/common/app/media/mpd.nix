{ pkgs, lib, ... }:

{
  services.mpd = {
    enable = true;
    musicDirectory = "~/music/";
    extraConfig = ''
      audio_output {
            type "pulse"
            name "My PulseAudio" # this can be whatever you want
      }
    '';
  };

  home.packages = with pkgs; [
    mpc
    ncmpcpp
  ];
}
