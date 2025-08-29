vim.g.rustaceanvim = {
  server = {
    on_attach = function(client, bufnr)
      if client.name ~= "rust_analyzer" and client.name ~= "rust-analyzer" then
        return
      end

      local opts = { silent = true, buffer = bufnr }

      vim.keymap.set({ "n", "x" }, "<leader>ca", function()
        vim.cmd.RustLsp({ "codeAction" })
      end, opts)

      vim.keymap.set("n", "K", function()
        vim.cmd.RustLsp({ "hover", "actions" })
      end, opts)
    end,
  },
}

return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
}
