{config, inputs, ...}: {

    imports = [
        inputs.zen-browser.homeModules.beta
    ];

    home.file.".local/share/icc/AW2726DM-rtings.icm".source = ./color/AW2726DM-rtings.icm;

    programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;
        profiles.default.presets.betterfox.enable = true;


        profiles.default.settings = {
            "zen.workspaces.continue-where-left-off" = true;
            "zen.view.compact.hide-tabbar" = true;
            "zen.urlbar.behavior" = "float";
            "zen.welcome-screen.seen" = true;

            # Profilname wie in deiner Config
            "gfx.color_management.mode" = 1;          # alle Inhalte als sRGB behandeln
            "gfx.color_management.enablev4" = true;   # Pflicht: Profil ist ICC v4
            "gfx.color_management.display_profile" =
            "${config.home.homeDirectory}/.local/share/icc/AW2726DM-rtings.icm";
        };

        policies = let
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
    };
}
