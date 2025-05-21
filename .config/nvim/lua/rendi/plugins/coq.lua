return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    { "ms-jpq/coq_nvim", branch = "coq" },
    { "ms-jpq/coq.artifacts", branch = "artifacts" },
    { "ms-jpq/coq.thirdparty", branch = "3p" },
  },
  init = function()
    vim.g.coq_settings = {
      auto_start = true,
      keymap = {
        recommended = false,
        jump_to_mark = "<c-]>",
      },
      display = {
        statusline = {
          helo = false,
        },
      },
    }
  end,
  config = function()
    local lsp = require("lspconfig")
    local coq = require("coq")

    local function setup_lsp(server, opts)
      opts = opts or {}
      lsp[server].setup(coq.lsp_ensure_capabilities(opts))
    end

    local function configure_diagnostics(enabled)
      vim.diagnostic.config({
        virtual_text = enabled,
        signs = enabled,
        underline = enabled,
      })
    end

    local function set_keybindings()
      vim.keymap.set("n", "<leader>dh", function()
        configure_diagnostics(false)
      end, { desc = "Hide Diagnostics" })
      vim.keymap.set("n", "<leader>ds", function()
        configure_diagnostics(true)
      end, { desc = "Show Diagnostics" })

      vim.api.nvim_set_keymap(
        "i",
        "<Esc>",
        [[pumvisible() ? "\<C-e><Esc>" : "\<Esc>"]],
        { expr = true, silent = true, desc = "Close/Cancel Completion" }
      )
      vim.api.nvim_set_keymap(
        "i",
        "<C-c>",
        [[pumvisible() ? "\<C-e><C-c>" : "\<C-c>"]],
        { expr = true, silent = true, desc = "Interrupt" }
      )
      vim.api.nvim_set_keymap(
        "i",
        "<BS>",
        [[pumvisible() ? "\<C-e><BS>" : "\<BS>"]],
        { expr = true, silent = true, desc = "Backspace" }
      )
      vim.api.nvim_set_keymap(
        "i",
        "<Tab>",
        [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]],
        { expr = true, silent = true, desc = "Accept/Trigger Completion" }
      )
      vim.api.nvim_set_keymap(
        "i",
        "<C-n>",
        [[pumvisible() ? "\<C-n>" : "\<Tab>"]],
        { expr = true, silent = true, desc = "Next Completion Item" }
      )
      vim.api.nvim_set_keymap(
        "i",
        "<C-p>",
        [[pumvisible() ? "\<C-p>" : "\<BS>"]],
        { expr = true, silent = true, desc = "Previous Completion Item" }
      )
    end

    local function setup_lsp_servers()
      setup_lsp("ts_ls", {
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
        root_dir = lsp.util.root_pattern("package.json", "tsconfig.json", ".git") or vim.fn.getcwd(),
      })

      setup_lsp("html", {
        filetypes = { "html" },
        root_dir = lsp.util.root_pattern(".git") or vim.fn.getcwd(),
      })

      -- setup_lsp("cssls", {
      --   filetypes = { "css", "scss" },
      -- })

      -- setup_lsp("asm_lsp", {
      --   filetypes = { "asm", "nasm" },
      -- })

      -- setup_lsp("tailwindcss", {
      --   filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescriptreact" },
      --   root_dir = function(fname)
      --     return lsp.util.root_pattern("tailwind.config.js", ".git")(fname) or vim.fn.getcwd()
      --   end,
      -- })

      setup_lsp("lua_ls", {
        filetypes = { "lua" },
        settings = {
          Lua = {
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- setup_lsp("graphql", {
      --   filetypes = { "graphql", "gql" },
      -- })

      -- setup_lsp("emmet_ls", {
      --   filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
      -- })

      -- setup_lsp("prismals", {
      --   filetypes = { "prisma" },
      -- })

      -- setup_lsp("pyright", {
      --   filetypes = { "python" },
      --   settings = {
      --     python = {
      --       analysis = {
      --         typeCheckingMode = "basic",
      --       },
      --     },
      --   },
      -- })
    end

    configure_diagnostics(true)
    set_keybindings()
    setup_lsp_servers()
  end,
}
