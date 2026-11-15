{...}:{
    # Enable Sound
    security.rtkit.enable = true;
    services.pipewire = {
        jack.enable = true;
    };

    #Grant audio & realtime privileges to your user
    users.users."hrolgard".extraGroups = [ "audio" "realtime" ];

    #Lock memory & set realtime priority limits for DAWs
    security.pam.loginLimits = [
        { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
        { domain = "@audio"; item = "rtprio";  type = "-"; value = "99"; }
    ];

    #Set Power Management to performance
    powerManagement.cpuFreqGovernor = "performance";

    programs.gamemode = {
        enable = true;
        settings.general.desiredgov = "performance";
  };
}
