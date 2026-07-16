{config, pkgs, ...}:

{
    home.username = "hrolgard";
    home.homeDirectory = "/home/hrolgard";

    home.stateVersion = "26.05";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
        discord
    ];
}
