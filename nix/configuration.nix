{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix

    # Core modules
    ./modules/nix.nix
    ./modules/networking.nix
    ./modules/common
    ./modules/audio.nix
    ./modules/shell.nix
    ./users.nix

    # Bootloader & system basics
    ./modules/bootloader.nix
    ./modules/locale.nix
    ./modules/virtualisation # This will now contain your libvirt/qemu logic

    # Graphics
    ./modules/graphics.nix

    ./modules/bluetooth.nix
    ./modules/xrdp.nix

    # Desktop modules
    ./modules/desktop
    ./modules/printer.nix
  ];
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    nix-index
    qemu
    quickemu
    virt-viewer # Recommended for viewing root-session VMs
  ];

  # UEFI firmware support for QEMU-based tools
  systemd.tmpfiles.rules = [
    "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware"
  ];

  # Enable running binaries of other architectures via binfmt
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "riscv64-linux"
  ];

  # Prefer libvirt as Vagrant's default provider
  environment.variables.VAGRANT_DEFAULT_PROVIDER = "libvirt";

  system.stateVersion = "25.11";
}
