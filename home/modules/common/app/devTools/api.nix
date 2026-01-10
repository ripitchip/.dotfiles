{ pkgs, ... }:
let
  hoppscotch-wrapped = pkgs-unstable.writeShellScriptBin "hoppscotch" ''
    WEBKIT_DISABLE_DMABUF_RENDERER=1 ${pkgs-unstable.hoppscotch}/bin/hoppscotch "$@"
  '';
in
{
  home.packages = (
    with pkgs;
    [
      httpie
      httpie-desktop
      yaak
      hoppscotch-wrapped
    ]
  );

  xdg.desktopEntries.hoppscotch = {
    name = "Hoppscotch";
    genericName = "API Client";
    exec = "${hoppscotch-wrapped}/bin/hoppscotch"; # sets WEBKIT_DISABLE_DMABUF_RENDERER=1
    icon = "${pkgs-unstable.hoppscotch}/usr/share/icons/hicolor/256x256@2/apps/hoppscotch-desktop.png";
    terminal = false;
    type = "Application";
    categories = [
      "Development"
      "Network"
    ];
  };
}
