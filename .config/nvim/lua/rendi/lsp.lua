local keymap = vim.keymap
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    if vim.bo[ev.buf].filetype == "rust" then return end

    local opts = { buffer = ev.buf, silent = true }

    opts.desc = "Show LSP references"
    keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

    opts.desc = "Go to declaration"
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    opts.desc = "Show LSP definition"
    keymap.set("n", "gd", vim.lsp.buf.definition, opts)

    opts.desc = "Show LSP implementations"
    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

    opts.desc = "Show LSP type definitions"
    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

    opts.desc = "Smart rename"
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

    opts.desc = "Go to previous diagnostic"
    keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, opts)

    opts.desc = "Go to next diagnostic"
    keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, opts)

    opts.desc = "Show documentation"
    keymap.set("n", "K", vim.lsp.buf.hover, opts)

    opts.desc = "Show signature help"
    keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

    opts.desc = "Toggle inlay hints"
    keymap.set("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, opts)

    opts.desc = "Show incoming calls"
    keymap.set("n", "<leader>ci", vim.lsp.buf.incoming_calls, opts)

    opts.desc = "Show outgoing calls"
    keymap.set("n", "<leader>co", vim.lsp.buf.outgoing_calls, opts)

    opts.desc = "Add workspace folder"
    keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)

    opts.desc = "List workspace folders"
    keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = ev.buf,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = ev.buf,
      callback = vim.lsp.buf.clear_references,
    })
  end,
})

vim.lsp.inlay_hint.enable(true)

local severity = vim.diagnostic.severity

vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = {
    text = {
      [severity.ERROR] = " ",
      [severity.WARN] = " ",
      [severity.HINT] = "󰠠 ",
      [severity.INFO] = " ",
    },
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
})

vim.api.nvim_create_user_command("LspInfo", "Lsp", {})
