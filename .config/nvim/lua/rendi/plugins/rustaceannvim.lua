return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(_, bufnr)
          local map = function(keys, cmd)
            vim.keymap.set("n", keys, function()
              vim.cmd.RustLsp(cmd)
            end, { silent = true, buffer = bufnr })
          end

          map("<leader>ca", "codeAction")
          map("K", { "hover", "actions" })
        end,
      },
    }
  end,
}
