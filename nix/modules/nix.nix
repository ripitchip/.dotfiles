{ config, pkgs, lib, ... }:

{
  # Nix-specific settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
}

