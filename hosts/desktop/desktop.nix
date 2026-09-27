{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/gaming.nix
      ../../modules/secureboot_lanzaboote.nix
    ];
}
