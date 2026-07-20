{pkgs, ...}: {

    # List packages installed in system profile. To search, run:
    # $ nix search [regex]
    environment.systemPackages = with pkgs; [
        kdePackages.kate
        pkgs.onlyoffice-desktopeditors
        qt6.qtwayland
        xwayland
        xwayland-satellite
    ];

    environment.sessionVariables = {
        QT_QPA_PLATFORM = "wayland;xcb";
    };

    programs.firefox.enable = true;
    programs.git.enable = true;
    programs.thunderbird.enable = true;
    programs.fish.enable = true;
}
