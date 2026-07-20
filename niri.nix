{...}: {

    programs.niri = {
        enable = true;
        withXwayland = true;
    };
    systemd.user.services.niri.enableDefaultPath = false;
}
