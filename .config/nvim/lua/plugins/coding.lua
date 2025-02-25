return {
	--  exchange/replace
	{
		"gbprod/substitute.nvim",
		opts = {},
    -- stylua: ignore start
    keys = {
      { "gr",  function() require('substitute').operator() end },
      { "grr", function() require('substitute').line() end },
      { "gR",  function() require('substitute').eol() end },
      { "gr",  function() require('substitute').visual() end,           mode = "x" },
      { "cx",  function() require('substitute.exchange').operator() end },
      { "cxx", function() require('substitute.exchange').line() end },
      { "X",   function() require('substitute.exchange').visual() end,  mode = "x" },
      { "cxc", function() require('substitute.exchange').cancel() end },
    },
		-- stylua: ignore end
		vscode = true,
	},
	-- move default gr to gR
	{
		"neovim/nvim-lspconfig",
		opts = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			-- disable a keymap
			keys[#keys + 1] = { "gr", false }
			-- add a keymap
			keys[#keys + 1] = {
				"gR",
				function()
					Snacks.picker.lsp_references()
				end,
				nowait = true,
				desc = "References",
			}
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters = {
				black = {
					prepend_args = { "--line-length=120", "--target-version=py36" },
				},
			},
		},
	},
	{
		"amitds1997/remote-nvim.nvim",
		version = "*", -- Pin to GitHub releases
		dependencies = {
			"nvim-lua/plenary.nvim", -- For standard functions
			"MunifTanjim/nui.nvim", -- To build the plugin UI
			"nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
		},
		config = true,
	},
	-- * doesn't advance to the next match, to better support cgn
	{
		"haya14busa/vim-asterisk",
		keys = {
			{ "*", mode = { "n", "x", "o" }, "<Plug>(asterisk-z*)" },
			{ "#", mode = { "n", "x", "o" }, "<Plug>(asterisk-z#)" },
			{ "g*", mode = { "n", "x", "o" }, "<Plug>(asterisk-gz*)" },
			{ "g#", mode = { "n", "x", "o" }, "<Plug>(asterisk-gz#)" },
		},
		vscode = true,
	},
	-- better subword motions
	{
		"chrisgrieser/nvim-spider",
		keys = {
			{
				"e",
				"<cmd>lua require('spider').motion('e')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"w",
				"<cmd>lua require('spider').motion('w')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"b",
				"<cmd>lua require('spider').motion('b')<CR>",
				mode = { "n", "o", "x" },
			},
			{
				"ge",
				"<cmd>lua require('spider').motion('ge')<CR>",
				mode = { "n", "o", "x" },
			},
		},
		vscode = true,
	},
	-- text-objects
	{ "PeterRincker/vim-argumentative", vscode = true }, -- <, shift argument, [, move argument, , - argument
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		opts = {
			custom_textobjects = {
				v = { -- subword with case
					{ "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
					"^().*()$",
				},
			},
		},
	},
	{
		"RRethy/nvim-treesitter-textsubjects",
		event = "VeryLazy",
		vscode = true,
		config = function()
			require("nvim-treesitter.configs").setup({
				textsubjects = {
					enable = true,
					keymaps = {
						["<CR>"] = "textsubjects-smart",
						["a<CR>"] = { "textsubjects-container-outer", desc = "Select around container" },
						["i<CR>"] = {
							"textsubjects-container-inner",
							desc = "Select inside containers (classes, functions, etc.)",
						},
					},
				},
			})
		end,
		keys = {
			{
				"<CR>",
				function()
					require("nvim-treesitter.textsubjects").select(
						"textsubjects-smart",
						false,
						vim.fn.getpos("."),
						vim.fn.getpos(".")
					)
				end,
				desc = "Text Subjects",
				mode = "n",
			},
		},
	},
	{
		"aaronik/treewalker.nvim",
		opts = {
			highlight = true, -- default is false
		},
		keys = {
			{ "<C-j>", "<cmd>Treewalker Down<CR>", mode = "n" },
			{ "<C-k>", "<cmd>Treewalker Up<CR>", mode = "n" },
			{ "<C-h>", "<cmd>Treewalker Left<CR>", mode = "n" },
			{ "<C-l>", "<cmd>Treewalker Right<CR>", mode = "n" },
			{ "<C-A-j>", "<cmd>Treewalker SwapDown<CR>", mode = "n" },
			{ "<C-A-k>", "<cmd>Treewalker SwapUp<CR>", mode = "n" },
			{ "<C-A-h>", "<cmd>Treewalker SwapLeft<CR>", mode = "n" },
			{ "<C-A-l>", "<cmd>Treewalker SwapRight<CR>", mode = "n" },
		},
	},
	{
		"saghen/blink.cmp",
		opts = {
			keymap = {
				preset = "enter",
				["<C-L>"] = {
					LazyVim.cmp.map({ "ai_accept" }),
					"fallback",
				},
				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return false
						else
							return cmp.select_next()
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = {
					"snippet_backward",
					"select_prev",
					"fallback",
				},
				["<C-y>"] = { "select_and_accept" },
			},
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					-- "ripgrep",
				},
				providers = {
					-- ripgrep = {
					-- 	module = "blink-ripgrep",
					-- 	name = "Ripgrep",
					-- },
					-- lsp = {
					-- score_offset = 3, -- Boost/penalize the score of the items
					-- },
				},
			},
			completion = {
				-- menu = {
				-- 	draw = {
				-- 		columns = { { "item_idx" }, { "kind_icon" }, { "label", "label_description", gap = 1 } },
				-- 		components = {
				-- 			item_idx = {
				-- 				text = function(ctx)
				-- 					return tostring(ctx.idx)
				-- 				end,
				-- 			},
				-- 		},
				-- 	},
				-- },
				list = {
					selection = { preselect = false, auto_insert = true },
				},
			},
		},
		dependencies = {
			-- {
			-- 	"saghen/blink.compat",
			-- 	"mikavilpas/blink-ripgrep.nvim",
			-- },
			-- {
			--   "supermaven-nvim",
			--   opts = {
			--     disable_inline_completion = false,
			--   },
			-- },
		},
	},
}
