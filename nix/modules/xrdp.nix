{ pkgs, ... }:

{
  services.xrdp.enable = true; # optional, for RDP

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    3389
    5900
    8000
  ]; # RDP + VNC

  environment.systemPackages = with pkgs; [
    wayvnc
    wlroots
    freerdp
    remmina
  ];

  # X11 DE for RDP, optional
  services.xserver.desktopManager.xfce.enable = true;

  # Optional: systemd service for wayvnc
  systemd.user.services.wayvnc = {
    description = "WayVNC server for Hyprland";
    after = [ "graphical-session.target" ];
    serviceConfig = {
      # Run as your user, not root
      ExecStart = "${pkgs.wayvnc}/bin/wayvnc 0.0.0.0 5900 -o DP-7 --render-cursor --websocket";
      Restart = "always";
      Environment = ''
        WAYLAND_DISPLAY=wayland-1
        XDG_RUNTIME_DIR=/run/user/1000
      '';
    };
    wantedBy = [ "default.target" ];
    enable = true;
  };

}
