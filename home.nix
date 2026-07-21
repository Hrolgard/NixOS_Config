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
        nextcloud-client
    ];

    #imports
    imports = [
        ./home_kitty.nix
        ./home_zen.nix
        ./home_noctalia.nix
    ];

    # !-- Niri Configuration --!

    xdg.configFile."niri/config.kdl".source = ./niri-configuration.kdl;

    programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
    #services.polkit-gnome.enable = true; # polkit
    #home.packages = with pkgs; [
    #    swaybg # wallpaper
    #];
}
