# nix/users.nix
{
  config,
  pkgs,
  pkgs-unstable,
  pkgs-zen-browser,
  inputs,
  lib,
  ...
}:

{
  users.users.thomas = {
    isNormalUser = true;
    description = "thomas";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "libvirtd"
      "kvm"
      "scanner"
      "lp"
      "lpadmin"
    ];
    shell = pkgs.fish;
  };

  # Attach Home Manager for this user
  home-manager.users.thomas = import ../home/home.nix;

  # Pass special args to home-manager
  home-manager.extraSpecialArgs = {
    inherit
      inputs
      pkgs
      pkgs-zen-browser
      pkgs-unstable
      ;
  };
}
