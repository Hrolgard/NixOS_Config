{pkgs, ...}: {
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            eamodio.gitlens
            esbenp.prettier-vscode
            oderwat.indent-rainbow
            zainchen.json
            mechatroner.rainbow-csv
        ];
    };
}

