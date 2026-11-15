{ config, pkgs, lib, inputs, ... }:

let
  reaperImGuiLibs = lib.makeLibraryPath [
    pkgs.freetype
    pkgs.libpng
    pkgs.zlib
    pkgs.fontconfig
    pkgs.libepoxy
    pkgs.gtk3
    pkgs.cairo
    pkgs.glib
    pkgs.stdenv.cc.cc.lib
    pkgs.libGL
  ];

  # Wraps the reaper binary in PATH without overriding reaper-flake's internal wrapper
  reaperWithLibs = pkgs.writeShellScriptBin "reaper" ''
    export LD_LIBRARY_PATH="${reaperImGuiLibs}:/run/opengl-driver/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    exec ${config.programs.reaper.package}/bin/reaper "$@"
  '';
in
{
  imports = [
    inputs.reaper-flake.homeModules.reaper
  ];

  # --- Declarative REAPER, Themes, SWS & ReaPack Configuration ---
  programs.reaper = {
    enable = true;

    theme = {
      active = "Reapertips Theme.ReaperThemeZip";
      packages = [
        inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.reapertips-theme
        inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.part-theme
      ];
    };

    extensions = {
      sws.enable = true;
      reapack = {
        enable = true;
        synchronizeOnActivation = true;
         repositories = [
          {
            name = "Reapertips";
            url = "https://github.com/Reapertips/ReaScripts/raw/master/index.xml";
          }
          {
            name = "Sexan_Scripts";
            url = "https://github.com/GoranKovac/ReaScripts/raw/master/index.xml";
          }
          {
            name = "FTC Tools";
            url = "https://raw.githubusercontent.com/iliaspoulakis/Reaper-Tools/master/index.xml";
          }
          {
            name = "BirdBird ReaScript Testing";
            url = "https://github.com/Bird-Bird/ReaScript_Testing/raw/main/index.xml";
          }
          {
            name = "Tukan";
            url = "https://github.com/TukanStudios/TUKAN_STUDIOS_PLUGINS/raw/main/index2.xml";
          }
        ];
        packages = [
          # --- Essential GUI Dependencies ---
          {
            repository = "ReaTeam Extensions";
            category = "API";
            name = "ReaImGui: ReaScript binding for Dear ImGui";
          }
          {
            repository = "ReaTeam Extensions";
            category = "API";
            name = "js_ReaScriptAPI: API functions for ReaScripts";
          }

          # --- Modern Workflow & UI ---
          {
            repository = "Reapertips";
            category = "Utility";
            name = "Reapertips_Project Launcher.lua";
          }
          {
            repository = "Reapertips";
            category = "Utility";
            name = "Reapertips_Time selection color for loop and record.lua";
          }
          {
            repository = "Sexan_Scripts";
            category = "FX";
            name = "Sexan_FX_Browser_ParserV7.lua";
          }
          {
            repository = "Sexan_Scripts";
            category = "ParanormalFX";
            name = "Sexan_ParaNormal_FX_Router.lua";
          }
          {
            repository = "FTC Tools";
            category = "Adaptive grid";
            name = "Adaptive grid.lua";
          }
          {
            repository = "FTC Tools";
            category = "MIDI editor";
            name = "Lil Chordbox.lua";
          }

          # --- Mixing & Studio Effects (Tukan JSFX) ---
          {
            repository = "Tukan";
            category = "..";
            name = "Series 2 (Tukan)";
          }
          {
            repository = "Tukan";
            category = "..";
            name = "Series 3 - Mixing Plugins";
          }

          # --- Guitar, Practice & Recording Tools ---
          {
            repository = "Reapertips";
            category = "Tuner";
            name = "Reapertips_TunerBox.lua";
          }
          {
            repository = "Reapertips";
            category = "Utility";
            name = "Reapertips_Speed Trainer.lua";
          }
          {
            repository = "BirdBird ReaScript Testing";
            category = "Global Sampler";
            name = "BirdBird_Global Sampler.lua";
          }
          {
            repository = "ReaTeam Scripts";
            category = "Items Editing";
            name = "mpl_Align takes.lua";
          }
        ];
      };
    };
  };

  home.packages = with pkgs; [
    # --- Wrapped REAPER launcher with ReaImGui libraries ---
    (lib.hiPrio reaperWithLibs)

    # --- Guitar Tablature & Band Collaboration ---
    tuxguitar

    # --- Guitar Amp Modeling & Overdrive ---
    neural-amp-modeler-lv2 # NAM amp/pedal capture loader (LV2)
    chow-centaur           # Native Klon Centaur overdrive

    # --- Native Linux Instruments & Effects ---
    vital
    surge-xt               # Hybrid synth for keys, pads & leads
    decent-sampler
    sfizz
    lsp-plugins
    dragonfly-reverb
    x42-plugins            # LUFS loudness/phase meters & studio utilities
    chow-tape-model        # Analog tape saturation

    # --- Audio Routing & Sample Utilities ---
    carla                  # Standalone plugin host & rack

    # --- Windows VST Bridge ---
    yabridge
    yabridgectl
    wineWow64Packages.staging
    winetricks
  ];

  # Ensure REAPER & Yabridge scan standard Linux & bridged plugin directories
  home.sessionVariables = {
    VST_PATH = "${config.home.homeDirectory}/.vst:/run/current-system/sw/lib/vst:${config.home.homeDirectory}/.nix-profile/lib/vst";
    VST3_PATH = "${config.home.homeDirectory}/.vst3:/run/current-system/sw/lib/vst3:${config.home.homeDirectory}/.nix-profile/lib/vst3";
    LV2_PATH = "${config.home.homeDirectory}/.lv2:/run/current-system/sw/lib/lv2:${config.home.homeDirectory}/.nix-profile/lib/lv2";
    CLAP_PATH = "${config.home.homeDirectory}/.clap:/run/current-system/sw/lib/clap:${config.home.homeDirectory}/.nix-profile/lib/clap";
  };

  # Ensure Reaper starts with gamemode and ReaImGui libraries
  xdg.desktopEntries.reaper = {
    name = "REAPER (Gamemode)";
    exec = "gamemoderun ${reaperWithLibs}/bin/reaper %F";
    icon = "cockos-reaper";
    terminal = false;
    categories = [ "AudioVideo" "Audio" "Recorder" ];
  };
}
