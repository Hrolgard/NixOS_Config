{ pkgs }:
with pkgs.vscode-extensions; [
    rust-lang.rust-analyzer
    tamasfe.even-better-toml
    usernamehw.errorlens
    vadimcn.vscode-lldb
]

