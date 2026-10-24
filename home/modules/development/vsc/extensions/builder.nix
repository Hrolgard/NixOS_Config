{ pkgs }:
with pkgs.vscode-extensions; [
    dbaeumer.vscode-eslint
    esbenp.prettier-vscode
    bradlc.vscode-tailwindcss
    vitest.explorer
    ms-python.python
    ms-python.vscode-pylance
    charliermarsh.ruff #python linter
]
