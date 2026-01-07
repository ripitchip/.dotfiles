{ pkgs, ... }:
{
  # Enable dconf so we can programmatically set desktop settings (virt-manager autoconnect)

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
  home.packages = with pkgs; [
    vagrant
    virt-manager
    qemu
  ];
}
