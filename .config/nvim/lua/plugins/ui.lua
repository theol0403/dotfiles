return {
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
	{
		"akinsho/bufferline.nvim",
		keys = {
			{ "<leader>,", "<Cmd>BufferLinePick<CR>", desc = "Pick buffer" },
		},
		opts = { options = { always_show_bufferline = true } },
	},
	{ "tiagovla/scope.nvim", opts = {} },
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
	-- {
	-- 	"petertriho/nvim-scrollbar",
	-- 	event = "BufReadPost",
	-- 	opts = {
	-- 		set_highlights = false,
	-- 		excluded_filetypes = {
	-- 			"prompt",
	-- 			"TelescopePrompt",
	-- 			"noice",
	-- 			"neo-tree",
	-- 			"dashboard",
	-- 			"alpha",
	-- 			"lazy",
	-- 			"mason",
	-- 			"DressingInput",
	-- 			"",
	-- 		},
	-- 		handlers = {
	-- 			gitsigns = true,
	-- 		},
	-- 	},
	-- },
	---@module "neominimap.config.meta"
	{
		"Isrothy/neominimap.nvim",
		version = "v3.*.*",
		enabled = true,
		lazy = false, -- NOTE: NO NEED to Lazy load
		-- Optional
		keys = {
			-- Global Minimap Controls
			{ "<leader>nm", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
			{ "<leader>no", "<cmd>Neominimap on<cr>", desc = "Enable global minimap" },
			{ "<leader>nc", "<cmd>Neominimap off<cr>", desc = "Disable global minimap" },
			{ "<leader>nr", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },

			-- Window-Specific Minimap Controls
			{ "<leader>nwt", "<cmd>Neominimap winToggle<cr>", desc = "Toggle minimap for current window" },
			{ "<leader>nwr", "<cmd>Neominimap winRefresh<cr>", desc = "Refresh minimap for current window" },
			{ "<leader>nwo", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
			{ "<leader>nwc", "<cmd>Neominimap winOff<cr>", desc = "Disable minimap for current window" },

			-- Tab-Specific Minimap Controls
			{ "<leader>ntt", "<cmd>Neominimap tabToggle<cr>", desc = "Toggle minimap for current tab" },
			{ "<leader>ntr", "<cmd>Neominimap tabRefresh<cr>", desc = "Refresh minimap for current tab" },
			{ "<leader>nto", "<cmd>Neominimap tabOn<cr>", desc = "Enable minimap for current tab" },
			{ "<leader>ntc", "<cmd>Neominimap tabOff<cr>", desc = "Disable minimap for current tab" },

			-- Buffer-Specific Minimap Controls
			{ "<leader>nbt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
			{ "<leader>nbr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
			{ "<leader>nbo", "<cmd>Neominimap bufOn<cr>", desc = "Enable minimap for current buffer" },
			{ "<leader>nbc", "<cmd>Neominimap bufOff<cr>", desc = "Disable minimap for current buffer" },

			---Focus Controls
			{ "<leader>nf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
			{ "<leader>nu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
			{ "<leader>ns", "<cmd>Neominimap toggleFocus<cr>", desc = "Switch focus on minimap" },
		},
		init = function()
			-- The following options are recommended when layout == "float"
			vim.opt.wrap = false
			vim.opt.sidescrolloff = 36 -- Set a large value

			--- Put your configuration here
			---@type Neominimap.UserConfig
			vim.g.neominimap = {
				auto_enable = false,
				exclude_filetypes = {
					"prompt",
					"TelescopePrompt",
					"noice",
					"neo-tree",
					"dashboard",
					"alpha",
					"lazy",
					"mason",
					"DressingInput",
					"help",
				},
			}
		end,
	},
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
}
