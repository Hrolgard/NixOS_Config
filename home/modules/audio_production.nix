{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.reaper-flake.homeModules.reaper
  ];

  # --- Declarative REAPER, SWS & ReaPack Configuration ---
  programs.reaper = {
    enable = true;
    extensions = {
      sws.enable = true;
      reapack = {
        enable = true;
        synchronizeOnActivation = true;
        repositories = [
          # Add custom third-party repositories here
        ];
        packages = [
          # Add declarative ReaPack scripts/effects here
        ];
      };
    };
  };

  home.packages = with pkgs; [
    # --- Guitar Tablature & Band Collaboration ---
    tuxguitar            # Native Linux Guitar Pro (.gp/.gpx/.tg) & MIDI tab editor

    # --- Native Linux Instruments & Effects ---
    vital                # Great synth for sketching pop/symphonic/rock ideas
    decent-sampler       # Native sample player (great for pianos, strings, & converted Studio One sets)
    sfizz                # Native SFZ player for free orchestral & guitar libraries
    lsp-plugins          # Comprehensive studio EQ, compressor, & limiter suite
    dragonfly-reverb     # High-quality native algorithmic reverbs

    # --- Windows VST Bridge ---
    yabridge
    yabridgectl
    wineWow64Packages.staging # Wine-Staging for running Melodyne installer & VST3
    winetricks
  ];

  # Ensure REAPER & Yabridge scan standard Linux & bridged plugin directories
  home.sessionVariables = {
    VST_PATH = "${config.home.homeDirectory}/.vst:/run/current-system/sw/lib/vst:${config.home.homeDirectory}/.nix-profile/lib/vst";
    VST3_PATH = "${config.home.homeDirectory}/.vst3:/run/current-system/sw/lib/vst3:${config.home.homeDirectory}/.nix-profile/lib/vst3";
    LV2_PATH = "${config.home.homeDirectory}/.lv2:/run/current-system/sw/lib/lv2:${config.home.homeDirectory}/.nix-profile/lib/lv2";
    CLAP_PATH = "${config.home.homeDirectory}/.clap:/run/current-system/sw/lib/clap:${config.home.homeDirectory}/.nix-profile/lib/clap";
  };

  # Ensure Reaper starts with gamemode
  xdg.desktopEntries.reaper = {
    name = "REAPER (Gamemode)";
    exec = "gamemoderun reaper %F";
    icon = "cockos-reaper";
    terminal = false;
    categories = [ "AudioVideo" "Audio" "Recorder" ];
  };
}
