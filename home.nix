{config, pkgs, system, lib, inputs, ...}:

{
    #Home definitions
    home.username = "hrolgard";
    home.homeDirectory = "/home/hrolgard";

    home.stateVersion = "26.05";

    programs.home-manager.enable = true;


    #packages
    home.packages = with pkgs; [
        discord
    ];

    #imports
    imports = [
        inputs.zen-browser.homeModules.beta
    ];

    # !-- Kitty --!

    programs.kitty = lib.mkForce {
        enable = true;
        shellIntegration.enableFishIntegration = true;
        settings = {
            shell = "fish";
            confirm_os_window_close = 0;
            dynamic_background_opacity = true;
            enable_audio_bell = false;
            mouse_hide_wait = "-1.0";
            window_padding_width = 10;
            background_opacity = "0.5";
            background_blur = 5;
            symbol_map = let
                mappings = [
                "U+23FB-U+23FE"
                "U+2B58"
                "U+E200-U+E2A9"
                "U+E0A0-U+E0A3"
                "U+E0B0-U+E0BF"
                "U+E0C0-U+E0C8"
                "U+E0CC-U+E0CF"
                "U+E0D0-U+E0D2"
                "U+E0D4"
                "U+E700-U+E7C5"
                "U+F000-U+F2E0"
                "U+2665"
                "U+26A1"
                "U+F400-U+F4A8"
                "U+F67C"
                "U+E000-U+E00A"
                "U+F300-U+F313"
                "U+E5FA-U+E62B"
                ];
            in
                (builtins.concatStringsSep "," mappings) + " Symbols Nerd Font";
        };
    };

    # !-- Niri Configuration --!

    xdg.configFile."niri/config.kdl".source = ./niri-configuration.kdl;

    programs.alacritty.enable = true; # Super+T in the default setting (terminal)
    programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
    #services.polkit-gnome.enable = true; # polkit
    #home.packages = with pkgs; [
    #    swaybg # wallpaper
    #];



    # !-- Zen Browser --!

    programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;
        profiles.default.presets.betterfox.enable = true;
    };

    programs.zen-browser.profiles.default.settings = {
        "zen.workspaces.continue-where-left-off" = true;
        "zen.view.compact.hide-tabbar" = true;
        "zen.urlbar.behavior" = "float";
        "zen.welcome-screen.seen" = true;
  };


    programs.zen-browser.policies = let
        mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
            installation_mode = "force_installed";
        });
    in {
        ExtensionSettings = mkExtensionSettings {
            "uBlock0@raymondhill.net" = "ublock-origin";
            "sponsorBlocker@ajay.app" = "sponsorblock";
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
        };

        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
        };
    };

}
