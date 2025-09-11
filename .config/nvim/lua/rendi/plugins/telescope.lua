return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "LukasPietzschmann/telescope-tabs",
    {
      "folke/todo-comments.nvim",
      opts = {},
    },
    "nvim-telescope/telescope-file-browser.nvim",
    {
      "AckslD/nvim-neoclip.lua",
      dependencies = {
        { "kkharji/sqlite.lua", module = "sqlite" },
      },
      config = function()
        require("neoclip").setup({
          history = 1000,
          enable_persistent_history = true,
          length_limit = 1048576,
          continuous_sync = true,
          preview = true,
          default_register = { '"', "+", "*" },
          enable_system_clipboard = true,
          keys = {
            telescope = {
              i = {
                select = "<cr>",
                paste = "<c-j>",
                paste_behind = "<c-k>",
                replay = "<c-q>",
                delete = "<c-d>",
              },
              n = {
                select = "<cr>",
                paste = "p",
                paste_behind = "P",
                replay = "q",
                delete = "d",
              },
            },
          },
        })
      end,
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod
    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        file_ignore_patterns = { "node_modules" },
        mappings = {
          i = {
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-s>"] = trouble_telescope.open,
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("telescope-tabs")
    pcall(telescope.load_extension, "todo-comments")
    telescope.load_extension("neoclip")

    local keymap = vim.keymap.set
    keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap("n", "<space>fb", function()
      require("telescope").extensions.file_browser.file_browser()
    end)
    keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap("n", "<leader>ft", "<cmd>Telescope telescope-tabs list_tabs<cr>", { desc = "Find tabs" })
    keymap("n", "<leader>fd", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap("n", "<leader>fy", function()
      require("telescope").extensions.neoclip.plus({ extra = '",star' })
    end, { desc = "Clipboard history (system + unnamed + star)" })
  end,
  cmd = { "Telescope" },
}
