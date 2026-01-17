{ pkgs-staging-next, ... }:

{
  # Enable CUPS and Epson Drivers
  services.printing = {
    enable = true;
    package = pkgs-staging-next.cups;
    drivers = [ pkgs-staging-next.epson-escpr2 ];
  };

  # Enable SANE for Scanning
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs-staging-next.sane-airscan ];
    # This line stops the 'escl' backend from causing that HTML error
    disabledDefaultBackends = [ "escl" ];
  };

  # Network Discovery (Required for both printing & scanning)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Declarative Printer Setup
  # hardware.printers = {
  #   ensurePrinters = [
  #     {
  #       name = "Epson_WF7835";
  #       location = "Home";
  #       deviceUri = "ipp://192.168.1.58/ipp/print";
  #       model = "everywhere";
  #       ppdOptions = {
  #         PageSize = "A4";
  #       };
  #     }
  #   ];
  #   ensureDefaultPrinter = "Epson_WF7835";
  # };
}
