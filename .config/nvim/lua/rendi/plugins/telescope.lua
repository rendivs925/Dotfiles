return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "LukasPietzschmann/telescope-tabs",
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-file-browser.nvim",

    {
      "Marskey/telescope-sg",
      dependencies = { "nvim-telescope/telescope.nvim" },
    },

    {
      "folke/todo-comments.nvim",
      opts = {},
    },

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
          continuous_sync = false,
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
      open_trouble_qflist = function()
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        file_ignore_patterns = { "node_modules" },
        preview = {
          treesitter = false,
        },
        mappings = {
          i = {
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-s>"] = actions.cycle_previewers_next,
            ["<C-a>"] = actions.cycle_previewers_prev,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<Esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
            ["<C-/>"] = "which_key",
          },
          n = {
            ["q"] = actions.close,
            ["?"] = "which_key",
          },
        },
      },

      pickers = {
        find_files = {
          hidden = true,
          follow = true,
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        live_grep = {
          additional_args = { "--hidden", "--no-ignore-vcs", "--glob", "!**/.git/*" },
        },
        buffers = {
          ignore_current_buffer = true,
          sort_lastused = true,
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
        oldfiles = {
          only_cwd = true,
        },
      },

      extensions = {
        media_files = {
          find_cmd = "rg",
        },
        ast_grep = {
          command = { "sg", "--json=stream" },
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    })

    telescope.load_extension("media_files")
    telescope.load_extension("fzf")
    telescope.load_extension("telescope-tabs")
    telescope.load_extension("file_browser")
    telescope.load_extension("neoclip")
    telescope.load_extension("ast_grep")
    telescope.load_extension("ui-select")
    pcall(telescope.load_extension, "todo-comments")

    local keymap = vim.keymap.set

    -- Files
    keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
    keymap("n", "<leader>fF", "<cmd>Telescope find_files hidden=true<cr>", { desc = "Find files (incl hidden)" })
    keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
    keymap("n", "<leader>fB", function()
      require("telescope").extensions.file_browser.file_browser({ path = vim.fn.expand("%:p:h") })
    end, { desc = "File browser" })

    -- Grep / search
    keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Grep project" })
    keymap("n", "<leader>fS", "<cmd>Telescope grep_string<cr>", { desc = "Grep word under cursor" })
    keymap("n", "<leader>fa", "<cmd>Telescope ast_grep<cr>", { desc = "AST grep" })
    keymap("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Fuzzy find in buffer" })

    -- Code / symbols
    keymap("n", "<leader>fi", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document symbols" })
    keymap("n", "<leader>fW", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Workspace symbols" })
    keymap("n", "<leader>fc", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
    keymap("n", "<leader>fC", "<cmd>Telescope lsp_implementations<cr>", { desc = "Implementations" })

    -- Buffers / tabs
    keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
    keymap("n", "<leader>ft", "<cmd>Telescope telescope-tabs list_tabs<cr>", { desc = "Tabs" })

    -- Git
    keymap("n", "<leader>fg", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
    keymap("n", "<leader>fG", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
    keymap("n", "<leader>fgB", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })

    -- Diagnostics
    keymap("n", "<leader>fd", "<cmd>TodoTelescope<cr>", { desc = "Todos" })
    keymap("n", "<leader>fD", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace diagnostics" })

    -- History / help
    keymap("n", "<leader>fy", function()
      require("telescope").extensions.neoclip.plus({ extra = '",star' })
    end, { desc = "Clipboard history" })
    keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
    keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
    keymap("n", "<leader>f.", "<cmd>Telescope commands<cr>", { desc = "Commands" })
    keymap("n", "<leader>f;", "<cmd>Telescope command_history<cr>", { desc = "Command history" })
    keymap("n", "<leader>fR", "<cmd>Telescope resume<cr>", { desc = "Resume last picker" })
    keymap("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix list" })
    keymap("n", "<leader>fl", "<cmd>Telescope loclist<cr>", { desc = "Location list" })
    keymap("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "Jump list" })
  end,
}
