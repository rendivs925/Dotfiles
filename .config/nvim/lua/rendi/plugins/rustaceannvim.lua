vim.g.rustaceanvim = {
  -- Global settings for rust-analyzer performance
  default_settings = {
    ["rust-analyzer"] = {
      -- 1. Disable aggressive indexing on startup to save initial memory
      cachePriming = {
        enable = false,
      },
      -- 2. Exclude large directories that don't contain Rust code (adjust paths as needed)
      files = {
        excludeDirs = {
          "node_modules",
          "dist",
          "pkg", -- Example: exclude wasm-pack output
          ".git", -- Generally good practice to exclude
        },
      },
      -- 3. Separate RA's build artifacts from your main Cargo builds
      cargo = {
        extraArgs = { "--target-dir", "target-rust-analyzer" },
      },
      -- 4. Use 'clippy' as the default check command
      check = {
        command = "clippy",
        -- optional: add extra arguments, e.g., to deny all warnings
        -- extraArgs = { "--", "-D", "warnings" },
      },
      -- 5. Disable automatic checks on save to prevent memory spikes on every file save
      checkOnSave = {
        enable = false,
      },
      -- 6. Optional: Lower the LRU cache capacity to force RA to drop memory faster
      -- lru = {
      --   capacity = 44,
      -- },
    },
  },

  -- LSP Server attachment and keymaps
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

      -- Restart rust-analyzer (useful for immediate memory reduction/refresh)
      vim.keymap.set("n", "<leader>rr", function()
        vim.cmd.RustLsp("restart")
        print("rust-analyzer restarted")
      end, opts)

      -- Manual trigger for Clippy/check diagnostics (since checkOnSave is false)
      vim.keymap.set("n", "<leader>dc", function()
        vim.cmd.RustLsp("runFlycheck")
        print("Running Clippy manually...")
      end, opts)
    end,
  },
}

return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
}
