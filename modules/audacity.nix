{...}:{
    environment.systemPackages = with pkgs; [
        audacity
    ];
    powerManagement.cpuFreqGovernor = "performance";
}
