return {
	-- zellij nav
	{
		"https://github.com/fresh2dev/zellij.vim.git",
		lazy = false,
		init = function()
			vim.cmd([[autocmd DirChanged,BufEnter *
      \ if &buftype == '' |
      \ call system('zellij action rename-tab "' . fnamemodify(getcwd(), ':t') . '"') |
      \ endif]])
		end,
		keys = {
			{ "<A-h>", "<cmd>ZellijNavigateLeft!<cr>" },
			{ "<A-l>", "<cmd>ZellijNavigateRight!<cr>" },
			{ "<A-j>", "<cmd>ZellijNavigateDown!<cr>" },
			{ "<A-k>", "<cmd>ZellijNavigateUp!<cr>" },
		},
	},
	-- scope buffers to tabs
	{ "tiagovla/scope.nvim", opts = {} },
	-- theme
	{
		"loctvl842/monokai-pro.nvim",
		lazy = false,
		branch = "master",
		priority = 1000,
		config = function()
			local monokai = require("monokai-pro")
			monokai.setup({
				transparent_background = false,
				devicons = true,
				filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
				inc_search = "background", -- underline | background
				background_clear = {},
				plugins = {
					bufferline = {
						underline_selected = true,
						underline_visible = true,
						bold = false,
					},
					indent_blankline = {
						context_highlight = "pro", -- default | pro
						context_start_underline = true,
					},
				},
				override = function(c)
					return {
						colorcolumn = { bg = c.base.dimmed3 },
						dashboardrecent = { fg = c.base.magenta },
						dashboardproject = { fg = c.base.blue },
						dashboardconfiguration = { fg = c.base.white },
						dashboardsession = { fg = c.base.green },
						dashboardlazy = { fg = c.base.cyan },
						dashboardserver = { fg = c.base.yellow },
						dashboardquit = { fg = c.base.red },
					}
				end,
			})
			monokai.load()
		end,
	},
	-- make cursor line and column respond to current window
	{
		"tummetott/reticle.nvim",
		config = true,
		init = function()
			vim.wo.cursorline = true
			vim.wo.cursorcolumn = false
		end,
	},
	-- { "myusuf3/numbers.vim", vscode = true },
	{
		"dinhhuy258/git.nvim",
		opts = {},
	},
	-- good search and replace (comparable to default gruq-far)
	{
		"chrisgrieser/nvim-rip-substitute",
		cmd = "RipSubstitute",
		keys = {
			{
				"<leader>rs",
				function()
					require("rip-substitute").sub()
				end,
				mode = { "n", "x" },
				desc = " rip substitute",
			},
		},
	},
	-- {
	-- 	"folke/which-key.nvim",
	-- 	opts = {
	-- 		plugins = {
	-- 			registers = false,
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"lewis6991/satellite.nvim",
	-- 	opts = {},
	-- },
	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		opts = {
			set_highlights = false,
			excluded_filetypes = {
				"prompt",
				"TelescopePrompt",
				"noice",
				"neo-tree",
				"dashboard",
				"alpha",
				"lazy",
				"mason",
				"DressingInput",
				"",
			},
			handlers = {
				gitsigns = true,
			},
		},
	},
}
