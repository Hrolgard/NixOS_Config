{pkgs, ...}: {

    # List packages installed in system profile. To search, run:
    # $ nix search [regex]
    environment.systemPackages = with pkgs; [
        kdePackages.kate
    ];

    programs.firefox.enable = true;
    programs.git.enable = true;
    programs.thunderbird.enable = true;
}
