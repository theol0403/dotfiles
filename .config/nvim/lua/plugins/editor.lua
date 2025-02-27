return {
	{ "tommcdo/vim-lion", vscode = true }, --- allign to separator using gl
	-- surround
	{
		"kylechui/nvim-surround",
		config = {
			keymaps = {
				insert = "<C-g>z",
				insert_line = "<C-g>Z",
				normal = "gz",
				normal_line = "gZ", -- adding caps makes it surround top and bottom
				normal_cur = "gzz",
				normal_cur_line = "gZZ", -- adding caps makes it surround top and bottom
				visual = "gz",
				visual_line = "gZ",
				delete = "gzd",
				change = "gzc",
			},
			aliases = {
				["a"] = ">",
				["b"] = ")",
				["B"] = "}",
				["r"] = "]",
				["q"] = { '"', "'", "`" },
				["z"] = { "}", "]", ")", ">", '"', "'", "`" },
			},
		},
		vscode = true,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		vscode = true,
		---@type Flash.Config
		opts = {
			modes = {
				char = {
					highlight = { backdrop = false },
				},
			},
		},
	},
	-- {
	-- 	"ggandor/leap.nvim",
	-- 	enabled = true,
	-- 	keys = {
	-- 		{ "s", mode = { "n", "x", "o" }, desc = "Leap" },
	-- 		{ "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
	-- 	},
	-- 	config = function(_, opts)
	-- 		local leap = require("leap")
	-- 		for k, v in pairs(opts) do
	-- 			leap.opts[k] = v
	-- 		end
	-- 		leap.add_default_mappings(true)
	-- 		-- vim.keymap.del({ "x", "o" }, "x")
	-- 		-- vim.keymap.del({ "x", "o" }, "X")
	-- 		vim.keymap.set("n", "s", function()
	-- 			require("leap").leap({ target_windows = { vim.api.nvim_get_current_win() } })
	-- 		end)
	-- 	end,
	-- },
	{
		"MagicDuck/grug-far.nvim",
		keys = {
			{
				"<leader>sf", -- find in local file
				function()
					require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
				end,
				mode = { "n", "v" },
				desc = "Search and Replace (current file)",
			},
		},
	},
	-- { "xiyaowong/fast-cursor-move.nvim", vscode = true },
	-- best tui file manager
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
	{
		"brenton-leighton/multiple-cursors.nvim",
		version = "*", -- Use the latest tagged version
		opts = {
			match_visible_only = false,
		},
		vscode = true,
		keys = {
			{ "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "x" }, desc = "Add cursor and move down" },
			{ "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "x" }, desc = "Add cursor and move up" },
			{ "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
			{
				"<C-Down>",
				"<Cmd>MultipleCursorsAddDown<CR>",
				mode = { "n", "i", "x" },
				desc = "Add cursor and move down",
			},
			{
				"<C-LeftMouse>",
				"<Cmd>MultipleCursorsMouseAddDelete<CR>",
				mode = { "n", "i" },
				desc = "Add or remove cursor",
			},
			{
				"gmi",
				"<Cmd>MultipleCursorsAddVisualArea<CR>",
				mode = { "x" },
				desc = "Add cursors to the lines of the visual area",
			},
			{ "gma", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" }, desc = "Add cursors to cword" },
			{
				"gmA",
				"<cmd>multipleCursorsAddMatchesV<CR>",
				mode = { "n", "x" },
				desc = "Add cursors to cword in previous area",
			},
			{
				"gmd",
				"<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
				mode = { "n", "x" },
				desc = "Add cursor and jump to next cword",
			},
			{ "gmD", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = { "n", "x" }, desc = "Jump to next cword" },
			{ "gml", "<Cmd>MultipleCursorsLock<CR>", mode = { "n", "x" }, desc = "Lock virtual cursors" },
		},
	},
}
