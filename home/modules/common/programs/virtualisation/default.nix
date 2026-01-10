{ pkgs, ... }:
{
  # Enable dconf so we can programmatically set desktop settings (virt-manager autoconnect)

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # Optional: Force shell tools to use the system daemon
  home.sessionVariables = {
    LIBVIRT_DEFAULT_URI = "qemu:///system";
  };
  home.packages = with pkgs; [
    vagrant
  ];
}
