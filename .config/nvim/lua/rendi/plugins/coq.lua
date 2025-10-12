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
        jump_to_mark = "<c-m>",
      },
      display = {
        statusline = {
          helo = false,
        },
      },
    }
  end,
  config = function()
    local coq = require("coq")
    local lsp_util = require("lspconfig.util") -- needed for root_pattern

    -- Toggle diagnostics
    local function configure_diagnostics(enabled)
      vim.diagnostic.config({
        virtual_text = enabled,
        signs = enabled,
        underline = enabled,
      })
    end

    -- Keymaps for LSP and completion
    local function on_attach(client, bufnr)
      local function buf_map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- Toggle diagnostics
      buf_map("n", "<leader>dh", function()
        configure_diagnostics(false)
      end, { desc = "Hide Diagnostics" })
      buf_map("n", "<leader>ds", function()
        configure_diagnostics(true)
      end, { desc = "Show Diagnostics" })

      -- Completion keymaps
      local expr_opts = { expr = true, silent = true }
      buf_map("i", "<Esc>", [[pumvisible() ? "\<C-e><Esc>" : "\<Esc>"]], expr_opts)
      buf_map("i", "<C-c>", [[pumvisible() ? "\<C-e><C-c>" : "\<C-c>"]], expr_opts)
      buf_map("i", "<BS>", [[pumvisible() ? "\<C-e><BS>" : "\<BS>"]], expr_opts)
      buf_map(
        "i",
        "<Tab>",
        [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]],
        expr_opts
      )
      buf_map("i", "<C-n>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], expr_opts)
      buf_map("i", "<C-p>", [[pumvisible() ? "\<C-p>" : "\<BS>"]], expr_opts)
    end

    -- Helper to setup server with COQ capabilities
    local function setup_server(server_name, opts)
      opts = opts or {}
      opts.on_attach = on_attach
      opts.capabilities = coq.lsp_ensure_capabilities(vim.lsp.protocol.make_client_capabilities())
      vim.lsp.config(server_name, opts)
      vim.lsp.enable(server_name)
    end

    configure_diagnostics(true)

    -- === LSP servers ===
    setup_server("tsserver", {
      filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
      root_dir = lsp_util.root_pattern("package.json", "tsconfig.json", ".git"),
    })

    setup_server("html", {
      filetypes = { "html" },
      root_dir = lsp_util.root_pattern(".git"),
    })

    setup_server("cssls", {
      filetypes = { "css", "scss" },
    })

    setup_server("tailwindcss", {
      filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescriptreact" },
      root_dir = function(fname)
        return lsp_util.root_pattern("tailwind.config.js", ".git")(fname) or vim.fn.getcwd()
      end,
    })

    setup_server("lua_ls", {
      filetypes = { "lua" },
      settings = {
        Lua = {
          workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          telemetry = { enable = false },
        },
      },
    })

    setup_server("graphql", {
      filetypes = { "graphql", "gql" },
    })

    setup_server("emmet_ls", {
      filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
    })

    -- Uncomment to enable other servers
    -- setup_server("pyright", { filetypes = { "python" }, settings = { python = { analysis = { typeCheckingMode = "basic" } } } })
    -- setup_server("prismals", { filetypes = { "prisma" } })
    -- setup_server("asm_lsp", { filetypes = { "asm", "nasm" } })
  end,
}
