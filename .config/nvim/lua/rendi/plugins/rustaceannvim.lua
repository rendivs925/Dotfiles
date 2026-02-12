vim.g.rustaceanvim = {
  server = {
    on_attach = function(_, bufnr)
      local opts = { silent = true, buffer = bufnr }

      vim.keymap.set({ "n", "x" }, "<leader>ca", function()
        vim.cmd.RustLsp("codeAction")
      end, opts)

      vim.keymap.set("n", "K", function()
        vim.cmd.RustLsp({ "hover", "actions" })
      end, opts)

      vim.keymap.set("n", "<leader>rr", function()
        vim.cmd.RustLsp("restart")
      end, opts)

      -- manual checks only
      vim.keymap.set("n", "<leader>ck", function()
        vim.cmd.RustLsp("runFlycheck")
      end, opts)

      vim.keymap.set("n", "<leader>cl", function()
        vim.cmd.RustLsp({ "runFlycheck", "clippy" })
      end, opts)
    end,

    default_settings = {
      ["rust-analyzer"] = {
        procMacro = { enable = true },

        -- This is the correct shape
        checkOnSave = { enable = false },

        -- Used when you *manually* run flycheck / check
        check = {
          command = "check",
        },

        -- These are valid and helpful
        lens = { enable = false },
        inlayHints = { enable = false },
        diagnostics = { enable = true },

        files = {
          excludeDirs = {
            "node_modules",
            "dist",
            "pkg",
            ".git",
            "target",
            "target-rust-analyzer",
            "debug",
          },
          watcherExclude = {
            "**/node_modules/**",
            "**/dist/**",
            "**/pkg/**",
            "**/.git/**",
            "**/target/**",
            "**/target-rust-analyzer/**",
            "**/debug/**",
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
