return {
  "neovim/nvim-lspconfig", -- REQUIRED: Native Neovim LSP integration
  lazy = false, -- REQUIRED: Start plugin at startup
  dependencies = {
    -- COQ for autocomplete
    { "ms-jpq/coq_nvim", branch = "coq" },
    { "ms-jpq/coq.artifacts", branch = "artifacts" },
    { "ms-jpq/coq.thirdparty", branch = "3p" },
  },
  init = function()
    vim.g.coq_settings = {
      auto_start = true, -- Auto-start COQ
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

    -- Utility function to simplify setup
    local function setup_lsp(server, opts)
      opts = opts or {}
      lsp[server].setup(coq.lsp_ensure_capabilities(opts)) -- Ensure COQ capabilities are added
    end

    -- Keymap for diagnostics
    local function hide_diagnostics()
      vim.diagnostic.config({
        virtual_text = false,
        signs = false,
        underline = false,
      })
    end

    local function show_diagnostics()
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
      })
    end

    vim.keymap.set("n", "<leader>dh", hide_diagnostics)
    vim.keymap.set("n", "<leader>ds", show_diagnostics)

    setup_lsp("ts_ls", { -- TypeScript LSP for embedded HTML (e.g., in Leptos components)
      filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
      root_dir = lsp.util.root_pattern("package.json", "tsconfig.json", ".git") or vim.fn.getcwd(),
    })

    -- HTML LSP
    setup_lsp("html", {
      root_dir = lsp.util.root_pattern(".git") or vim.fn.getcwd(),
    })

    -- Tailwind CSS
    setup_lsp("tailwindcss", {
      filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescriptreact" },
      root_dir = function(fname)
        return lsp.util.root_pattern("tailwind.config.js", ".git")(fname) or vim.fn.getcwd()
      end,
    })

    -- Keybindings for completion in insert mode
    vim.api.nvim_set_keymap("i", "<Esc>", [[pumvisible() ? "\<C-e><Esc>" : "\<Esc>"]], { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-c>", [[pumvisible() ? "\<C-e><C-c>" : "\<C-c>"]], { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<BS>", [[pumvisible() ? "\<C-e><BS>" : "\<BS>"]], { expr = true, silent = true })
    vim.api.nvim_set_keymap(
      "i",
      "<Tab>",
      [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]],
      { expr = true, silent = true }
    )
    vim.api.nvim_set_keymap("i", "<C-n>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-p>", [[pumvisible() ? "\<C-p>" : "\<BS>"]], { expr = true, silent = true })
  end,
}
