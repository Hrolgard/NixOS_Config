{inputs, ...}: {

    #imports
    imports = [
        inputs.noctalia.homeModules.default
    ];

    #Install Wallhaven
    home.file.".local/share/noctalia/plugins/noctalia/wallhaven" = {
        source = "${inputs.noctalia-plugins}/wallhaven";
        recursive = true;
    };

    #Configure Noctalia
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
                    "tray" "notifications" "clipboard" "network" "bluetooth" "volume" "brightness" "battery" "control-center" "noctalia/wallhaven:wallhaven" "session"
                ];
            };

            theme = {
                    source = "wallpaper";           # Dynamically extract colors from the active wallpaper
                    wallpaper_scheme = "m3-content"; # Color extraction algorithm (see options below)
                    mode = "dark";                  # "dark", "light", or "auto"
                    shell_mode = "follow";          # Keep Noctalia's shell UI synced with `mode`
                    terminal_colors = "palette";    # Generate matching ANSI colors for terminals
                    sync_color_scheme = true;       # Sync dark/light preference with GTK/GNOME apps

                templates = {
                    enable_builtin_templates = true;
                    enable_community_templates = true;
                    builtin_ids = [
                        "gtk3"
                        "gtk4"
                        "qt"
                        "breeze" # Generates ~/.local/share/color-schemes/Noctalia.colors for Kate/KDE
                        "kitty"  # Generates ~/.config/kitty/themes/noctalia.conf
                        "niri"   # Generates ~/.config/niri/noctalia.kdl
                    ];
                };
            };

            wallpaper = {
                enabled = true;
            };

            plugins = {
                enabled = [ "noctalia/wallhaven" ];
            };
        };
    };
}
