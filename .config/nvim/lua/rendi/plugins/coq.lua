return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    { "ms-jpq/coq_nvim", branch = "coq" },
    { "ms-jpq/coq.artifacts", branch = "artifacts" },
    { "ms-jpq/coq.thirdparty", branch = "3p" },
  },
  init = function()
    -- Coq settings are grouped together for clarity
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

    -- 1. Utility Functions
    --   - Centralize common setup logic.
    --   - Use `...` for variable arguments to handle options more cleanly.

    ---@param server string
    ---@param opts table
    local function setup_lsp(server, opts)
      opts = opts or {}
      lsp[server].setup(coq.lsp_ensure_capabilities(opts))
    end

    -- 2. Diagnostic Configuration
    --   - Encapsulate diagnostic settings.
    local function configure_diagnostics(enabled)
      vim.diagnostic.config({
        virtual_text = enabled,
        signs = enabled,
        underline = enabled,
      })
    end

    -- 3. Keybindings
    --   - Group keybindings logically.
    local function set_keybindings()
      vim.keymap.set("n", "<leader>dh", function()
        configure_diagnostics(false)
      end, { desc = "Hide Diagnostics" })
      vim.keymap.set("n", "<leader>ds", function()
        configure_diagnostics(true)
      end, { desc = "Show Diagnostics" })

      -- Completion keybindings (Insert mode)
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

    -- 4. LSP Server Setup
    --   - Group LSP server configurations.
    local function setup_lsp_servers()
      setup_lsp("ts_ls", { -- TypeScript
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
        root_dir = lsp.util.root_pattern("package.json", "tsconfig.json", ".git") or vim.fn.getcwd(),
      })

      setup_lsp("html", { -- HTML
        filetypes = { "html" },
        root_dir = lsp.util.root_pattern(".git") or vim.fn.getcwd(),
      })

      setup_lsp("cssls", { -- CSS
        filetypes = { "css", "scss" },
      })

      setup_lsp("asm_lsp", { -- Assembly
        filetypes = { "asm", "nasm" },
      })

      setup_lsp("tailwindcss", { -- Tailwind CSS
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescriptreact" },
        root_dir = function(fname)
          return lsp.util.root_pattern("tailwind.config.js", ".git")(fname) or vim.fn.getcwd()
        end,
      })

      setup_lsp("lua_ls", { -- Lua
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

      setup_lsp("graphql", { -- GraphQL
        filetypes = { "graphql", "gql" },
      })

      setup_lsp("emmet_ls", { -- Emmet
        filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
      })

      setup_lsp("prismals", { -- Prisma
        filetypes = { "prisma" },
      })

      setup_lsp("pyright", { -- Python
        filetypes = { "python" },
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
            },
          },
        },
      })
    end

    -- 5. Main Configuration Flow
    --   - Keep the main config function concise.
    configure_diagnostics(true) -- Enable diagnostics by default
    set_keybindings()
    setup_lsp_servers()
  end,
}
