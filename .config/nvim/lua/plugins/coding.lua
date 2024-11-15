return {
	-- fix surround-nvim
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
	--  exchange/replace
	{
		"gbprod/substitute.nvim",
		opts = {},
    -- stylua: ignore start
    keys = {
      { "gr", function() require('substitute').operator() end },
      { "grr", function() require('substitute').line() end },
      { "gR", function() require('substitute').eol() end },
      { "gr", function() require('substitute').visual() end, mode = "x" },
      { "cx", function() require('substitute.exchange').operator() end },
      { "cxx", function() require('substitute.exchange').line() end },
      { "X", function() require('substitute.exchange').visual() end, mode = "x" },
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
			keys[#keys + 1] = { "gR", vim.lsp.buf.references, desc = "References", nowait = true }
		end,
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
	-- Use <tab> for completion and snippets (supertab)
	{
		"hrsh7th/nvim-cmp",
		url = "https://github.com/theol0403/magazine.nvim",
		branch = "main",
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			opts.formatting.fields = { "num", "abbr", "kind", "menu" }
			opts.formatting.number_options = {
				start_index = 1,
				end_index = 9,
			}

			local cmp = require("cmp")

			opts.preselect = cmp.PreselectMode.None
			opts.completion = {
				completeopt = "menu,menuone,noinsert,noselect",
			}

			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				["<Tab>"] = cmp.mapping(function(fallback)
					if vim.snippet.active({ direction = 1 }) then
						vim.schedule(function()
							vim.snippet.jump(1)
						end)
					elseif cmp.visible() then
						cmp.select_next_item()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if vim.snippet.active({ direction = -1 }) then
						vim.schedule(function()
							vim.snippet.jump(-1)
						end)
					elseif cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<CR>"] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() and cmp.get_active_entry() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm({ select = true }),
					c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				}),
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		url = "https://github.com/theol0403/magazine.nvim",
		optional = true,
		dependencies = { "supermaven-nvim" },
		opts = function(_, opts)
			if vim.g.ai_cmp then
				table.insert(opts.sources, 1, {
					name = "supermaven",
					group_index = 1,
					priority = 100,
				})
			end
		end,
	},
}
