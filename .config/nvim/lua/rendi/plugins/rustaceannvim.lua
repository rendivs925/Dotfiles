vim.g.rustaceanvim = {
  server = {
    cmd = {
      vim.fn.expand("~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer"),
    },

    on_attach = function(_, bufnr)
      local opts = { silent = true, buffer = bufnr }

      vim.keymap.set({ "n", "x" }, "<leader>ca", function()
        vim.cmd.RustLsp("codeAction")
      end, opts)

      vim.keymap.set("n", "K", function()
        vim.cmd.RustLsp({ "hover", "actions" })
      end, opts)

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

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
        procMacro = {
          enable = true,
          ignored = {},
        },

        cargo = {
          target = "xtensa-esp32-none-elf",
          allFeatures = false,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
          buildScripts = {
            enable = true,
          },
        },

        checkOnSave = false,

        check = {
          command = "check",
          extraArgs = {
            "--target",
            "xtensa-esp32-none-elf",
          },
        },

        diagnostics = {
          enable = true,
          experimental = {
            enable = false,
          },
        },

        lens = {
          enable = false,
        },

        inlayHints = {
          enable = false,
        },

        completion = {
          autoimport = {
            enable = true,
          },
          fullFunctionSignatures = {
            enable = true,
          },
        },

        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },

        files = {
          excludeDirs = {
            ".git",
            "target",
            "node_modules",
            "dist",
            "pkg",
          },
          watcherExclude = {
            "**/.git/**",
            "**/target/**",
            "**/node_modules/**",
            "**/dist/**",
            "**/pkg/**",
          },
        },
      },
    },
  },

  tools = {
    hover_actions = {
      auto_focus = true,
    },
  },
}

return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
  ft = { "rust" },
}
