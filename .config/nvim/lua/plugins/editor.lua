return {
	{ "tommcdo/vim-lion", vscode = true }, --- allign to separator using gl
	-- fix surround-nvim errors
	{
		"folke/noice.nvim",
		opts = {
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "echomsg",
						find = "No textobject",
					},
					opts = { skip = true },
				},
			},
		},
	},
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
		-- opts = { highlight = { backdrop = false } },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
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
	-- replace <space><space> file finder with smart open, and move old behavior to <leader>.
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
			-- { "<leader>,", false },
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
