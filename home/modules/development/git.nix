{...}: {
    programs.git = {
        enable = true;
        settings.user = {
            name = "Hrolgard";
            email = "andreas.m.weber@pm.me";
        };

        aliases = {
            acp = "!f() { git add . && git commit -m \"$1\" && git push; }; f";
        };
    };
}
