{ pkgs, ... }: {
  programs.neovim = {
    enable = true;

    # Sets EDITOR and VISUAL (yazi opens files with $EDITOR)
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # UI
      tokyonight-nvim
      nvim-web-devicons
      lualine-nvim
      which-key-nvim

      # Navigation
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      yazi-nvim

      # Syntax
      nvim-treesitter.withAllGrammars

      # LSP and completion
      nvim-lspconfig
      blink-cmp

      # Rust
      rustaceanvim

      # Editing
      conform-nvim
      gitsigns-nvim
      nvim-autopairs

      # Tabs, file tree, git
      bufferline-nvim
      neo-tree-nvim
      nui-nvim
      diffview-nvim
      lazygit-nvim
    ];

    # Only on nvim's PATH, not installed system-wide
    extraPackages = with pkgs; [
      # Telescope and clipboard
      ripgrep
      fd
      wl-clipboard

      # Language servers
      nixd
      lua-language-server
      bash-language-server

      # Rust toolchain (rust-analyzer, formatter, linter)
      rust-analyzer
      rustfmt
      clippy
      cargo
      rustc

      # Formatters
      nixfmt
      stylua
      shfmt

      # Git UI (needed by lazygit.nvim)
      lazygit
    ];

    initLua = builtins.readFile ./init.lua;
  };
}
