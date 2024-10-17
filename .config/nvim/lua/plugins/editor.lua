return {
	{ "tommcdo/vim-lion", vscode = true },
	{ "tpope/vim-unimpaired", vscode = true },
	{
		"vscode-neovim/vscode-multi-cursor.nvim",
		event = "VeryLazy",
		cond = not not vim.g.vscode,
		vscode = true,
		keys = {
			{
				mode = { "n", "x", "i" },
				"<C-S-l>",
				function()
					require("vscode-multi-cursor").selectHighlights()
				end,
			},
		},
	},
	-- {
	--   "folke/flash.nvim",
	--   ---@type Flash.Config
	--   opts = { highlight = { backdrop = false } },
	-- },
	{
		"ggandor/leap.nvim",
		enabled = true,
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
			-- vim.keymap.del({ "x", "o" }, "x")
			-- vim.keymap.del({ "x", "o" }, "X")
			vim.keymap.set("n", "s", function()
				require("leap").leap({ target_windows = { vim.api.nvim_get_current_win() } })
			end)
		end,
	},
	{
		"danielfalk/smart-open.nvim",
		branch = "0.2.x",
		config = function()
			require("telescope").load_extension("smart_open")
		end,
		dependencies = {
			"kkharji/sqlite.lua",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-fzy-native.nvim" },
		},
		keys = {
			{
				"<leader><space>",
				function()
					require("telescope").extensions.smart_open.smart_open()
				end,
				desc = "Smart open",
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{ "<leader>,", false },
			{ "<leader><space>", false },
			{ "<leader>.", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
		},
	},
	{
		"leath-dub/snipe.nvim",
		keys = {
			{
				"gb",
				function()
					require("snipe").open_buffer_menu()
				end,
				desc = "Open Snipe buffer menu",
			},
		},
		opts = {},
	},
	{
		"voxelprismatic/rabbit.nvim",
		opts = {},
	},
	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>y",
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>Y",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				-- NOTE: this requires a version of yazi that includes
				-- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = true,
			keymaps = {
				show_help = "<f1>",
			},
		},
	},
}
