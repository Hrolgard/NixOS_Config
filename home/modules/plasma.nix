{ inputs, ... }: {
    imports = [
        inputs.plasma-manager.homeModules.plasma-manager
    ];

    programs.plasma = {
        enable = true;

        workspace = {
            lookAndFeel = "org.kde.breezedark.desktop";
            colorScheme = "BreezeDark";
            iconTheme = "Papirus-Dark";
        };
    };
}
