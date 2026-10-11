{ inputs, ... }: {
  imports = [ inputs.nix-craftapps.homeManagerModules.default ];

  programs.craftapps = {
    enable = true;

    apps.wordcraft.enable = true;
    apps.gridcraft.enable = true;
    apps.soundcraft.enable = true;
  };
}
