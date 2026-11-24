-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Options
local o = vim.opt
o.number = true
o.relativenumber = true
o.termguicolors = true
o.signcolumn = "yes"
o.cursorline = true
o.scrolloff = 8
o.ignorecase = true
o.smartcase = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.undofile = true
o.updatetime = 250
o.splitright = true
o.splitbelow = true
o.clipboard = "unnamedplus" -- needs wl-clipboard on Wayland

-- Colorscheme (transparent, so kitty's background_opacity still shows)
require("tokyonight").setup({
  style = "night",
  transparent = true,
  styles = { sidebars = "transparent", floats = "transparent" },
})
vim.cmd.colorscheme("tokyonight")

-- Small UI plugins
require("lualine").setup({ options = { theme = "auto", globalstatus = true } })
require("gitsigns").setup()
require("nvim-autopairs").setup()
require("which-key").setup()

-- Telescope
local telescope = require("telescope")
telescope.setup({})
pcall(telescope.load_extension, "fzf")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

-- Yazi inside Neovim
require("yazi").setup({ open_for_directories = false })
vim.keymap.set({ "n", "v" }, "<leader>e", "<cmd>Yazi<cr>", { desc = "Yazi (current file)" })
vim.keymap.set("n", "<leader>E", "<cmd>Yazi cwd<cr>", { desc = "Yazi (working directory)" })

-- Treesitter: parsers come from nixpkgs, highlighting is started by Neovim itself
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- Completion
require("blink.cmp").setup({
  keymap = { preset = "default" },
  sources = { default = { "lsp", "path", "buffer" } },
})

-- LSP (Neovim 0.11+ API, server defaults come from nvim-lspconfig)
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
vim.lsp.config("lua_ls", {
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})
vim.lsp.enable({ "nixd", "lua_ls", "bashls" })

vim.diagnostic.config({ virtual_text = true })

-- Formatting
require("conform").setup({
  formatters_by_ft = {
    nix = { "nixfmt" },
    lua = { "stylua" },
    sh = { "shfmt" },
  },
  format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
})
