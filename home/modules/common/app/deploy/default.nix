{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    terraform
    google-cloud-sdk
  ];
}
