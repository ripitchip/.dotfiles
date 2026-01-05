{ pkgs, ... }:
{
  home.pointerCursor =
    let
      getFrom = url: hash: name: {
        gtk.enable = true;
        x11.enable = true;
        name = name;
        size = 24;
        package = pkgs.runCommand "banana-cursor" { } ''
          mkdir -p $out/share/icons
          ln -s ${
            pkgs.fetchzip {
              url = url;
              sha256 = hash;
            }
          } $out/share/icons/${name}
        '';
      };
    in
    getFrom "https://github.com/ful1e5/banana-cursor/archive/refs/heads/main.zip"
      "sha256-tyva+mhJd0RBJ4FRT8e8IrGpk20FQImZgiaD2kv1La0="
      "banana-cursor";
}
