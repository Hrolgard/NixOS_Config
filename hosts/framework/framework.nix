{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/audio_production.nix
    ];


  #enable bluetooth
  hardware.bluetooth.enable = true;
}
