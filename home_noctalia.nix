{inputs, ...}: {

    #imports
    imports = [
        inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
        enable = true;
        settings = {
            bar.main = {
                position = "bottom";
                margin_edge = 0;
                reserve_space = false;
                smart_auto_hide = true;
                show_on_workspace_switch = true;
                thickness = 55;


                start  = [
                    "launcher"
                    "workspaces"
                ];
                center = [
                    "clock"
                ];
                end    = [
                    "tray" "notifications" "clipboard" "network" "bluetooth" "volume" "brightness" "battery" "control-center" "session"
                ];
            };
        };
    };
}
