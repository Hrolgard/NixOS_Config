{...}: {

    #imports
    imports = [
        inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
        enable = true;
        settings = {
            bar.main.position = "bottom";
        };
    };
}
