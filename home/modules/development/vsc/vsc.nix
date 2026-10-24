{pkgs, ...}: {
    programs.vscode = {
        enable = true;
        profiles.default.extensions =
            import ./extensions/general.nix { inherit pkgs; }
            ++ import ./extensions/rust.nix { inherit pkgs; }
            ++ import ./extensions/builder.nix { inherit pkgs; }
            ;
    };
}

