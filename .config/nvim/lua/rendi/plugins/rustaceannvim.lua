vim.g.rustaceanvim = {
  server = {
    on_attach = function(client, bufnr)
      -- Guard clause: ignore non-rust-analyzer clients
      local name = client.name
      if name ~= "rust_analyzer" and name ~= "rust-analyzer" then
        return
      end

      local opts = { silent = true, buffer = bufnr }

      -- Code actions
      vim.keymap.set({ "n", "x" }, "<leader>ca", function()
        vim.cmd.RustLsp("codeAction")
      end, opts)

      -- Hover + actions
      vim.keymap.set("n", "K", function()
        vim.cmd.RustLsp({ "hover", "actions" })
      end, opts)

      -- Restart analyzer (useful for memory spikes)
      vim.keymap.set("n", "<leader>rr", function()
        vim.cmd.RustLsp("restart")
        print("rust-analyzer restarted")
      end, opts)
    end,

    settings = {
      ["rust-analyzer"] = {
        check = {
          command = "check",
        },

        checkOnSave = {
          enable = false,
        },

        cargo = {
          loadOutDirsFromCheck = false,
          buildScripts = {
            enable = false,
          },
        },

        diagnostics = {
          enable = false,
        },

        procMacro = {
          enable = false,
        },

        completion = {
          autoimport = {
            enable = false,
          },
        },

        lens = {
          enable = false,
        },

        hover = {
          enable = false,
        },

        files = {
          excludeDirs = {
            "target",
            "**/target",
            "node_modules",
            "**/node_modules",
            "dist",
            "**/dist",
            ".git",
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
