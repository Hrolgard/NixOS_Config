{pkgs, ...}: {
    programs.vscode = {
        enable = true;
        profiles.default.extensions = with pkgs.vscode-extensions; [
            esbenp.prettier-vscode
            oderwat.indent-rainbow
            zainchen.json
            mechatroner.rainbow-csv
        ];
    };
}

