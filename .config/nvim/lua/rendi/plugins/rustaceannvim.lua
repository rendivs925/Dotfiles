vim.g.rustaceanvim = {
  server = {
    cmd = {
      "systemd-run",
      "--scope",
      "-p",
      "Slice=rust-analyzer.slice",
      "rust-analyzer",
    },

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

      vim.keymap.set("n", "<leader>ck", function()
        vim.cmd.RustLsp("runFlycheck")
      end, opts)

      vim.keymap.set("n", "<leader>cl", function()
        vim.cmd.RustLsp({ "runFlycheck", "clippy" })
      end, opts)
    end,

    default_settings = {
      ["rust-analyzer"] = {
        procMacro = { enable = false },
        checkOnSave = { enable = false },
        check = { command = "check" },

        lens = { enable = false },
        inlayHints = { enable = false },
        diagnostics = { enable = true },

        cargo = {
          allFeatures = false,
          loadOutDirsFromCheck = false,
          runBuildScriptsLocally = false,
        },

        compilationActions = { enable = false },

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

        ["rusty Crane"] = {
          liftComments = false,
        },

        memory = {
          addressSpace = "100MiB",
          declarativeItems = "100MiB",
          proceduralMacros = "100MiB",
          typeHints = "100MiB",
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
