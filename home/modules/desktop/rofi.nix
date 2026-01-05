{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      rofi
      wtype
    ]
    ++ [
      (cliphist.overrideAttrs (_old: {
        src = pkgs.fetchFromGitHub {
          owner = "sentriz";
          repo = "cliphist";
          rev = "efb61cb5b5a28d896c05a24ac83b9c39c96575f2";
          sha256 = "sha256-y4FSl/Bj80XqCR0ZwjGEkqYUIF6zJHrYyy01XPFlzjU=";
        };
      }))
    ];
  xdg.configFile."rofi" = {
    source = ./rofi;
  };

}
