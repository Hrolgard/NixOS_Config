/*
  This enables Secure Boot via Lanzaboote
  (It overrides the default Bootloader from configuration.nix)
  Only import this for a Host that needs Secureboot

  Before importing this Module, check the Instructions first.
  There are several steps, before & after enabling lanzaboote, that need to be done.
  We are breaking rule #1: "Never fuck with Grub" here, so be careful and do it by the book.

  See official docs for current step-by-step:
  https://nix-community.github.io/lanzaboote/
*/

{ pkgs, lib, inputs, ... }: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Force override the global systemd-boot option
  boot.loader.systemd-boot.enable = lib.mkForce false;

  # Enable Lanzaboote Secure Boot signing
  boot.lanzaboote = {
    enable = true;
    # We deviate the path from the docs, because sbctl wants it so
    pkiBundle = "/var/lib/sbctl";
  };

  environment.systemPackages = [ pkgs.sbctl ];
}
