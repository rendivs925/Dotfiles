vim.g.rustaceanvim = {
  server = {
    on_attach = function(client, bufnr)
      local opts = { silent = true, buffer = bufnr }

      -- Code actions
      vim.keymap.set({ "n", "x" }, "<leader>ca", function()
        vim.cmd.RustLsp("codeAction")
      end, opts)

      -- Hover + actions
      vim.keymap.set("n", "K", function()
        vim.cmd.RustLsp({ "hover", "actions" })
      end, opts)

      -- Restart rust-analyzer (useful for memory spikes)
      vim.keymap.set("n", "<leader>rr", function()
        vim.cmd.RustLsp("restart")
        print("rust-analyzer restarted")
      end, opts)
    end,
  },
}

return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
}
