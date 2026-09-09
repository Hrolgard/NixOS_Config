{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];


  #enable bluetooth
  hardware.bluetooth.enable = true;
}
