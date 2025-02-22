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
  { "junegunn/fzf", build = "./install --bin" },
  -- { "xiyaowong/fast-cursor-move.nvim", vscode = true },
  -- <leader>. to open frecency finder
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
        "<leader><CR>",
        function()
          require("telescope").extensions.smart_open.smart_open()
        end,
        desc = "Smart open",
      },
    },
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
