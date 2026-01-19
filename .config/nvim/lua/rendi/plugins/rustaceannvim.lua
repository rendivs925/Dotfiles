vim.g.rustaceanvim = {
  tools = {
    -- optional: disable inlay hints/lens here too (some versions read from tools)
    inlay_hints = { auto = false },
  },

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

        cargo = {
          buildScripts = { enable = false },
          allFeatures = false,
          -- If you want to pin features, add:
          -- features = { "csr" },
        },

        -- This is the correct shape (object, not boolean)
        checkOnSave = { enable = false },

        -- Used when you *manually* run flycheck / check
        check = {
          command = "check",
          extraArgs = { "--target-dir", "target-rust-analyzer" },
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
