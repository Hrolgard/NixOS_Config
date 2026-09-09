{ config, pkgs, ... }:
{
  # NVIDIA-Grafiktreiber (proprietaer, stable branch)
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting wird von Wayland/modernen Compositorn benoetigt
    modesetting.enable = true;

    # Aktuell empfohlene stabile Treiberversion (Production/Stable-Branch,
    # NICHT die neueste Beta/New-Feature-Version)
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Offene Kernel-Module (fuer Turing+ / Ampere, z.B. RTX 3080, offiziell
    # unterstuetzt und empfohlen)
    open = true;

    # Testweise deaktiviert; ggf. spaeter aktivieren, falls Suspend/Resume
    # Probleme macht oder gebraucht wird.
    powerManagement.enable = false;

    nvidiaSettings = true;
  };

  hardware.graphics.enable = true;

  # Steam & proton ge
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # gamemode
  programs.gamemode.enable = true;

  # ProtonUp-QT
  environment.systemPackages = with pkgs; [
  protonup-qt
];
}
