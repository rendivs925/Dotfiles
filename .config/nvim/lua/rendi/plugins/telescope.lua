return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  cmd = "Telescope",
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
    { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
    { "<leader>fB", function() require("telescope").extensions.file_browser.file_browser() end, desc = "File browser" },
    { "<leader>fr", function() require("telescope.builtin").oldfiles() end, desc = "Recent files" },
    { "<leader>fs", function() require("telescope.builtin").live_grep() end, desc = "Grep string" },
    { "<leader>fc", function() require("telescope.builtin").grep_string() end, desc = "Grep word under cursor" },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help tags" },
    { "<leader>fm", function() require("telescope.builtin").man_pages() end, desc = "Man pages" },
    { "<leader>fk", function() require("telescope.builtin").keymaps() end, desc = "Keymaps" },
    { "<leader>fco", function() require("telescope.builtin").commands() end, desc = "Commands" },
    { "<leader>ft", function() require("telescope").extensions["telescope-tabs"].list_tabs() end, desc = "Tabs" },
    { "<leader>fd", function() require("telescope.builtin").diagnostics() end, desc = "Diagnostics" },
    { "<leader>fds", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Document symbols" },
    { "<leader>fws", function() require("telescope.builtin").lsp_workspace_symbols() end, desc = "Workspace symbols" },
    { "<leader>fdr", function() require("telescope.builtin").lsp_references() end, desc = "References" },
    { "<leader>fdi", function() require("telescope.builtin").lsp_implementations() end, desc = "Implementations" },
    { "<leader>fdd", function() vim.lsp.buf.definition() end, desc = "Go to definition" },
    { "<leader>fdt", function() require("telescope.builtin").lsp_type_definitions() end, desc = "Type definitions" },
    { "<leader>fgc", function() require("telescope.builtin").git_commits() end, desc = "Git commits" },
    { "<leader>fgb", function() require("telescope.builtin").git_bcommits() end, desc = "Git buffer commits" },
    { "<leader>fgs", function() require("telescope.builtin").git_status() end, desc = "Git status" },
    { "<leader>fgB", function() require("telescope.builtin").git_branches() end, desc = "Git branches" },
    { "<leader>fgst", function() require("telescope.builtin").git_stash() end, desc = "Git stash" },
    { "<leader>fR", function() require("telescope.builtin").resume() end, desc = "Resume picker" },
    { "<leader>fj", function() require("telescope.builtin").jumplist() end, desc = "Jumplist" },
    { "<leader>f/", function() require("telescope.builtin").search_history() end, desc = "Search history" },
    { "<leader>f?", function() require("telescope.builtin").command_history() end, desc = "Command history" },
    { "<leader>fq", function() require("telescope.builtin").quickfix() end, desc = "Quickfix list" },
    { "<leader>fl", function() require("telescope.builtin").loclist() end, desc = "Location list" },
    { "<leader>fa", "<cmd>Telescope ast_grep<CR>", desc = "AST Grep" },
    { "<leader>fy", function() require("telescope").extensions.neoclip.plus({ extra = '",star' }) end, desc = "Clipboard history" },
    { "<leader>ftd", "<cmd>TodoTelescope<CR>", desc = "Todo comments" },
  },
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
        prompt_prefix = "> ",
        selection_caret = "> ",
        path_display = { "smart" },
        file_ignore_patterns = { "node_modules" },
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = true },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim",
        },
        find_command = {
          "fd",
          "--type", "f",
          "--hidden",
          "--follow",
          "--exclude", ".git",
          "--exclude", "node_modules",
        },
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        generic_sorter = require("telescope.sorters").get_fzy_sorter,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        filesize_limit = 1,
        set_env = { ["COLORTERM"] = "truecolor" },

        mappings = {
          i = {
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-s>"] = trouble_telescope.open,
            ["<C-a>"] = actions.cycle_previewers_prev,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<Esc>"] = actions.close,
            ["?"] = actions.which_key,
          },
          n = {
            ["?"] = actions.which_key,
          },
        },
      },

      pickers = {
        buffers = {
          sort_lastused = true,
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
          },
        },
        find_files = {
          hidden = true,
          follow = true,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
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
  end,
}
