{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Scanning Apps
    simple-scan # Best for quick PDFs/JPGs
    xsane # Best for advanced color correction/DPI control

    # Optional: Printer Management
    system-config-printer # Graphical tool to see ink levels and print queue
  ];
}
