return {
	{ "tommcdo/vim-lion", vscode = true }, --- allign to separator using gl
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
	-- {
	-- 	"brenton-leighton/multiple-cursors.nvim",
	-- 	version = "*", -- Use the latest tagged version
	-- 	opts = {
	-- 		match_visible_only = false,
	-- 	},
	-- 	keys = {
	-- 		{ "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "x" }, desc = "Add cursor and move down" },
	-- 		{ "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "x" }, desc = "Add cursor and move up" },
	-- 		{ "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
	-- 		{
	-- 			"<C-Down>",
	-- 			"<Cmd>MultipleCursorsAddDown<CR>",
	-- 			mode = { "n", "i", "x" },
	-- 			desc = "Add cursor and move down",
	-- 		},
	-- 		{
	-- 			"<C-LeftMouse>",
	-- 			"<Cmd>MultipleCursorsMouseAddDelete<CR>",
	-- 			mode = { "n", "i" },
	-- 			desc = "Add or remove cursor",
	-- 		},
	-- 		{
	-- 			"gmi",
	-- 			"<Cmd>MultipleCursorsAddVisualArea<CR>",
	-- 			mode = { "x" },
	-- 			desc = "Add cursors to the lines of the visual area",
	-- 		},
	-- 		{ "gma", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" }, desc = "Add cursors to cword" },
	-- 		{
	-- 			"gmA",
	-- 			"<cmd>multipleCursorsAddMatchesV<CR>",
	-- 			mode = { "n", "x" },
	-- 			desc = "Add cursors to cword in previous area",
	-- 		},
	-- 		{
	-- 			"gmd",
	-- 			"<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
	-- 			mode = { "n", "x" },
	-- 			desc = "Add cursor and jump to next cword",
	-- 		},
	-- 		{ "gmD", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = { "n", "x" }, desc = "Jump to next cword" },
	-- 		{ "gml", "<Cmd>MultipleCursorsLock<CR>", mode = { "n", "x" }, desc = "Lock virtual cursors" },
	-- 	},
	-- },
	{
		"jake-stewart/multicursor.nvim",
		vscode = true,
		config = function()
			local mc = require("multicursor-nvim")
			mc.setup()

			local set = vim.keymap.set

			-- Add cursor above/below the main cursor.
			set({ "n", "x" }, "gmk", function()
				mc.lineAddCursor(-1)
			end, { desc = "Add cursor above" })
			set({ "n", "x" }, "gmj", function()
				mc.lineAddCursor(1)
			end, { desc = "Add cursor below" })

			-- Add a new cursor by matching word/selection
			set({ "n", "x" }, "gmn", function()
				mc.matchAddCursor(1)
			end, { desc = "Add cursor to cword" })
			set({ "n", "x" }, "gmN", function()
				mc.matchAddCursor(-1)
			end, { desc = "Add cursor to prev cword" })

			-- Add a cursor to every search result in the buffer.
			set("n", "gm/", mc.searchAllAddCursors, { desc = "Add cursors to search result" })

			-- Add and remove cursors with control + left click.
			set("n", "<c-leftmouse>", mc.handleMouse)
			set("n", "<c-leftdrag>", mc.handleMouseDrag)
			set("n", "<c-leftrelease>", mc.handleMouseRelease)

			-- Disable and enable cursors.
			set({ "n", "x" }, "gmm", mc.toggleCursor, { desc = "Toggle multi cursor" })

			-- Delete the main cursor.
			set({ "n", "x" }, "gmd", mc.deleteCursor, { desc = "Delete main cursor" })

			-- bring back cursors if you accidentally clear them
			set("n", "gmv", mc.restoreCursors, { desc = "Restore cursors" })

			-- Add a cursor for all matches of cursor word/selection in the document.
			set({ "n", "x" }, "gma", mc.matchAllAddCursors, { desc = "Add cursors to cword in document" })

			-- Mappings defined in a keymap layer only apply when there are
			-- multiple cursors. This lets you have overlapping mappings.
			mc.addKeymapLayer(function(layerSet)
				-- Select a different cursor as the main one.
				layerSet({ "n", "x" }, "<left>", mc.prevCursor)
				layerSet({ "n", "x" }, "<right>", mc.nextCursor)

				-- Append/insert for each line of visual selections.
				-- Similar to block selection insertion.
				set("x", "I", mc.insertVisual)
				set("x", "A", mc.appendVisual)

				-- Increment/decrement sequences, treaing all cursors as one sequence.
				set({ "n", "x" }, "g<c-a>", mc.sequenceIncrement)
				set({ "n", "x" }, "g<c-x>", mc.sequenceDecrement)

				-- Enable and clear cursors using escape.
				layerSet("n", "<esc>", function()
					if not mc.cursorsEnabled() then
						mc.enableCursors()
					else
						mc.clearCursors()
					end
				end)
			end)

			-- Customize how cursors look.
			local hl = vim.api.nvim_set_hl
			hl(0, "MultiCursorCursor", { reverse = true })
			hl(0, "MultiCursorVisual", { link = "Visual" })
			hl(0, "MultiCursorSign", { link = "SignColumn" })
			hl(0, "MultiCursorMatchPreview", { link = "Search" })
			hl(0, "MultiCursorDisabledCursor", { reverse = true })
			hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
			hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		opts = {
			server = {
				default_settings = {
					["rust-analyzer"] = {
						cargo = {
							targetDir = true,
						},
					},
				},
			},
		},
	},
}
