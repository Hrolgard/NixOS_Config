{ pkgs, ... }: {
  programs.gamescope = {
    enable = true;
    enableWsi = true; # needed for HDR
  };

  programs.steam.gamescopeSession = {
    enable = true;
    args = [ "--hdr-enabled" ];
    env = {
      DXVK_HDR = "1";
      ENABLE_GAMESCOPE_WSI = "1";
    };
  };
  hardware.graphics = {
    extraPackages = [ pkgs.gamescope-wsi ];
    extraPackages32 = [ pkgs.pkgsi686Linux.gamescope-wsi ];
  };
}
