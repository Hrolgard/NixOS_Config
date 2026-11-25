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

-- File tree sidebar
require("neo-tree").setup({
	filesystem = {
		filtered_items = { visible = true },
		follow_current_file = { enabled = true },
	},
	window = { width = 30 },
})
vim.keymap.set("n", "<leader>t", "<cmd>Neotree toggle<cr>", { desc = "File tree" })

-- Git: diff view, file history, merge tool, lazygit
require("diffview").setup({})
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diff against HEAD" })
vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "History of this file" })
vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" })
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Lazygit" })

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
-- rust-analyzer is NOT listed here: rustaceanvim starts it
vim.lsp.enable({ "nixd", "lua_ls", "bashls" })

vim.diagnostic.config({ virtual_text = true })

-- gd: jump to definition (only where an LSP server is attached)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
			buffer = args.buf,
			desc = "Go to definition",
		})
	end,
})

-- Rust: rustaceanvim starts rust-analyzer itself
vim.g.rustaceanvim = {
	server = {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
		default_settings = {
			["rust-analyzer"] = { check = { command = "clippy" } },
		},
	},
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function(args)
		local map = function(lhs, cmd, desc)
			vim.keymap.set("n", lhs, cmd, { buffer = args.buf, desc = desc })
		end
		map("<leader>rr", function()
			vim.cmd.RustLsp("runnables")
		end, "Rust: runnables")
		map("<leader>rt", function()
			vim.cmd.RustLsp("testables")
		end, "Rust: testables")
		map("<leader>re", function()
			vim.cmd.RustLsp("expandMacro")
		end, "Rust: expand macro")
		map("<leader>rd", function()
			vim.cmd.RustLsp("renderDiagnostic")
		end, "Rust: show diagnostic")
	end,
})

-- Formatting
require("conform").setup({
	formatters_by_ft = {
		nix = { "nixfmt" },
		lua = { "stylua" },
		sh = { "shfmt" },
		rust = { "rustfmt" },
	},
	format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
})
