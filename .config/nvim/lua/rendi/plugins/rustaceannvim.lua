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

      -- Monitor memory usage (optional)
      vim.keymap.set("n", "<leader>rm", function()
        vim.cmd.RustLsp("restart")
        print("Restarted rust-analyzer due to memory usage")
      end, opts)
    end,

    settings = {
      ["rust-analyzer"] = {
        checkOnSave = { enable = false },
        cargo = {
          loadOutDirsFromCheck = false,
          buildScripts = { enable = false },
        },
        diagnostics = { enable = false },
        procMacro = { enable = false },
        completion = { autoimport = { enable = false } },
        lens = { enable = false },
        hover = { enable = false },
        files = {
          excludeDirs = {
            "target",
            "**/target",
            "node_modules",
            "**/build",
            "**/dist",
            "**/.git",
          },
        },
      },
    },
  },
}

return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
}
