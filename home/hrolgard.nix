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
        ./modules/kitty.nix
        ./modules/zen.nix
        ./modules/noctalia.nix
        ./modules/development/git.nix
        ./modules/plasma.nix
        ./modules/theme.nix
        ./modules/development/vsc.nix
    ];

    # !-- Niri Configuration --!

    xdg.configFile."niri/config.kdl".source = ./modules/niri-configuration.kdl;

    programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)

    #services.polkit-gnome.enable = true;
    #home.packages = with pkgs; [
    #    swaybg # wallpaper
    #];
}
