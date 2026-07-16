{config, pkgs, system, inputs, ...}:

{
    #Home definitions
    home.username = "hrolgard";
    home.homeDirectory = "/home/hrolgard";

    home.stateVersion = "26.05";

    programs.home-manager.enable = true;

    #imports
    imports = [
        inputs.zen-browser.homeModules.twilight
    ];

    #discord
    home.packages = with pkgs; [
        discord
        inputs.zen-browser.packages."${system}".default
    ];
}
