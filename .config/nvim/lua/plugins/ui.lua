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
			vim.g.zellij_navigator_no_default_mappings = 1
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
	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				always_show_bufferline = true,
			},
		},
	},
	-- theme
	{
		"loctvl842/monokai-pro.nvim",
		lazy = false,
		branch = "master",
		priority = 1000,
		config = function()
			local monokai = require("monokai-pro")
			monokai.setup({
				devicons = true,
				filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
				inc_search = "background", -- underline | background
				background_clear = {},
				plugins = {
					bufferline = {
						underline_selected = true,
						underline_visible = false,
						bold = false,
					},
					indent_blankline = {
						context_highlight = "pro", -- default | pro
						context_start_underline = true,
					},
				},
				override = function(c)
					local hp = require("monokai-pro.color_helper")
					local common_fg = hp.lighten(c.sideBar.foreground, 30)
					return {
						colorcolumn = { bg = c.base.dimmed3 },
						dashboardrecent = { fg = c.base.magenta },
						dashboardproject = { fg = c.base.blue },
						dashboardconfiguration = { fg = c.base.white },
						dashboardsession = { fg = c.base.green },
						dashboardlazy = { fg = c.base.cyan },
						dashboardserver = { fg = c.base.yellow },
						dashboardquit = { fg = c.base.red },
						DiagnosticUnderlineError = { undercurl = false, underline = true },
						DiagnosticUnderlineWarn = { undercurl = false, underline = true },
						DiagnosticUnderlineInfo = { undercurl = false, underline = true },
						DiagnosticUnderlineHint = { undercurl = false, underline = true },
						DiagnosticUnnecessary = { undercurl = false, underline = true },
						SnacksPicker = { bg = c.editor.background, fg = common_fg },
						SnacksPickerBorder = { bg = c.editor.background, fg = c.tab.unfocusedActiveBorder },
						SnacksPickerTree = { fg = c.editorLineNumber.foreground },
						NonText = { fg = c.base.dimmed3 }, -- not sure if this should be broken into all hl groups importing NonText
					}
				end,
			})
			monokai.load()
		end,
	},
	{
		"OXY2DEV/helpview.nvim",
		lazy = false,
	},
	-- { "myusuf3/numbers.vim", vscode = true },
	{
		"dinhhuy258/git.nvim",
		opts = {},
	},
	-- {
	-- 	"folke/which-key.nvim",
	-- 	opts = {
	-- 		plugins = {
	-- 			registers = false,
	-- 		},
	-- 	},
	-- },
	{
		"folke/which-key.nvim",
		opts = {
			preset = "classic",
		},
	},
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
				"snacks_picker_input",
				"",
			},
			handlers = {
				gitsigns = true,
			},
		},
	},
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			-- legacy_computing_symbols_support = true,
			normal_bg = "#373438",
			-- distance_stop_animating = 0.5,
		},
	},
	-- {
	-- 	"rachartier/tiny-glimmer.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		overwrite = {
	-- 			search = {
	-- 				enabled = true,
	-- 			},
	-- 			undo = {
	-- 				enabled = true,
	-- 			},
	-- 			redo = {
	-- 				enabled = true,
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		"snacks.nvim",
		opts = {
			scroll = { enabled = false },
			picker = {
				formatters = {
					file = {
						truncate = 100,
					},
				},
			},
		},
		keys = {
			{
				"<leader>.",
				function()
					Snacks.picker.smart()
				end,
				desc = "Smart Find Files",
			},
			{
				"<leader><space>",
				function()
					Snacks.picker.smart()
				end,
				desc = "Smart Find Files",
			},
		},
	},
	{
		"karb94/neoscroll.nvim",
		opts = {},
	},
}
