{ pkgs, ... }: {
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

    #shell aliases
    home.shellAliases = {
        # Behält die aktuelle + 2 ältere Systemgenerationen, räumt dann den Store auf
        nix-clean = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +3 && sudo nix-collect-garbage";
    };

    #imports
    imports = [
        ./modules/kitty.nix
        ./modules/zen.nix
        ./modules/noctalia.nix

        ./modules/development/git.nix
        ./modules/development/vsc/vsc.nix

        ./modules/default_apps.nix
        ./modules/plasma.nix
        ./modules/theme.nix

        ./modules/yazi.nix
        ./modules/neovim/neovim.nix

        #./modules/craftapps.nix
    ];

    #Niri Configuration
    xdg.configFile."niri/config.kdl".source = ./modules/niri-configuration.kdl;

    programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
    programs.fish.enable = true; #Shell
}
