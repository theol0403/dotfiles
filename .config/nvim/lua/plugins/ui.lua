return {
	-- zellij nav
	{
		"https://github.com/fresh2dev/zellij.vim.git",
		lazy = false,
		cond = not vim.g.neovide,
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
				-- background_clear = {
				-- 	"float_win",
				-- 	"toggleterm",
				-- 	"telescope",
				-- 	-- "which-key",
				-- 	"renamer",
				-- 	"notify",
				-- 	"nvim-tree",
				-- 	"neo-tree",
				-- 	-- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
				-- },
				plugins = {
					bufferline = {
						underline_selected = true,
						underline_visible = false,
						bold = true,
					},
					indent_blankline = {
						context_highlight = "pro", -- default | pro
						context_start_underline = true,
					},
				},
				override = function(c)
					vim.cmd([[hi @lsp.type.comment.c guifg=NONE]]) -- just for now
					vim.cmd([[hi @lsp.type.comment.cpp guifg=NONE]]) -- just for now
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
						-- DiagnosticUnderlineError = { undercurl = false, underline = true },
						-- DiagnosticUnderlineWarn = { undercurl = false, underline = true },
						-- DiagnosticUnderlineInfo = { undercurl = false, underline = true },
						-- DiagnosticUnderlineHint = { undercurl = false, underline = true },
						-- DiagnosticUnnecessary = { undercurl = false, underline = true },
						SnacksPicker = { bg = c.editor.background, fg = common_fg },
						SnacksPickerBorder = { bg = c.editor.background, fg = c.tab.unfocusedActiveBorder },
						SnacksPickerTree = { fg = c.editorLineNumber.foreground },
						SnacksPickerCol = { fg = c.editorLineNumber.foreground },
						NonText = { fg = c.base.dimmed3 }, -- not sure if this should be broken into all hl groups importing NonText
						FloatBorder = { fg = c.tab.unfocusedActiveBorder },
						-- NormalFloat = { bg = c.editorSuggestWidget.background },
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
	{ "lewis6991/satellite.nvim", dependencies = { "lewis6991/gitsigns.nvim", enabled = true } },
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
	-- 			"snacks_picker_input",
	-- 			"",
	-- 		},
	-- 		handlers = {
	-- 			gitsigns = true,
	-- 		},
	-- 	},
	-- },
	{
		"sphamba/smear-cursor.nvim",
		cond = not vim.g.neovide,
		opts = {
			-- legacy_computing_symbols_support = true,
			normal_bg = "#373438",
			-- distance_stop_animating = 0.5,
		},
	},
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
			styles = {
				lazygit = {
					wo = { winhighlight = "NormalFloat:Normal" },
				},
			},
			lazygit = {
				os = {
					edit = '[ -z "$NVIM" ] && (nvim -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{filename}})',
					editAtLine = '[ -z "$NVIM" ] && (nvim +{{line}} -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" &&  nvim --server "$NVIM" --remote {{filename}} && nvim --server "$NVIM" --remote-send ":{{line}}<CR>")',
					editAtLineAndWait = "nvim +{{line}} {{filename}}",
					openDirInEditor = '[ -z "$NVIM" ] && (nvim -- {{dir}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{dir}})',
				},
			},
		},
		keys = {
			{
				"<leader>.",
				function()
					Snacks.picker.smart({
						cwd = vim.fn.expand("%:p:h"),
						multi = {
							"files",
							"buffers",
						},
					})
				end,
				desc = "Find Files (in dir)",
			},
			-- {
			-- 	"<leader>.",
			-- 	function()
			-- 		Snacks.picker.pick({
			-- 			multi = {
			-- 				{
			-- 					source = "files",
			-- 					cwd = vim.fn.expand("%:p:h"),
			-- 					matcher = {
			-- 						cwd_bonus = true, -- boost cwd matches
			-- 						frecency = true, -- use frecency boosting
			-- 						sort_empty = true, -- sort even when the filter is empty
			-- 					},
			-- 					transform = function(item)
			-- 						item.score_add = (item.score_add or 0) + 10000
			-- 						return item
			-- 					end,
			-- 				},
			-- 				"buffers",
			-- 				"recent",
			-- 				"files",
			-- 			},
			-- 			format = "file", -- use `file` format for all sources
			-- 			matcher = {
			-- 				cwd_bonus = true, -- boost cwd matches
			-- 				frecency = true, -- use frecency boosting
			-- 				sort_empty = true, -- sort even when the filter is empty
			-- 			},
			-- 			transform = "unique_file",
			-- 		})
			-- 	end,
			-- 	desc = "Find Files (in dir)",
			-- },
			-- {
			-- 	"<leader>.",
			-- 	function()
			-- 		Snacks.picker.smart({
			-- 			multi = {
			-- 				{
			-- 					source = "smart",
			-- 					finder = "files",
			-- 					cwd = vim.fn.expand("%:p:h"),
			-- 				},
			-- 				-- "buffers",
			-- 				-- "recent",
			-- 				-- "files",
			-- 			},
			-- 		})
			-- 	end,
			-- 	desc = "Find Files (in dir)",
			-- },
			{
				"<leader><space>",
				function()
					Snacks.picker.smart({
						-- multi = {
						-- 	"files",
						-- 	"buffers",
						-- },
					})
				end,
				desc = "Smart Find Files",
			},
		},
	},
	{
		"folke/snacks.nvim",
		opts = function(_, opts)
			table.insert(opts.dashboard.preset.keys, 4, {
				icon = " ",
				key = "z",
				desc = "Zoxide",
				action = function()
					Snacks.picker.zoxide()
				end,
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		cond = not vim.g.neovide,
		opts = {},
	},
}
