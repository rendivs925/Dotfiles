return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  lazy = false,
  ft = { "rust" },
  config = function()
    local function find_linked_projects()
      local cwd = vim.fn.getcwd()
      local projects = {}
      local cargo_toml = cwd .. "/Cargo.toml"

      if vim.fn.filereadable(cargo_toml) == 1 then
        table.insert(projects, cargo_toml)
      else
        local handle = io.popen('find "' .. cwd .. '" -name "Cargo.toml" -maxdepth 2')
        if handle then
          for path in handle:lines() do
            table.insert(projects, path)
          end
          handle:close()
        end
      end

      return #projects > 0 and projects or nil
    end

    vim.g.rustaceanvim = {
      server = {
        autostart = true,
        on_attach = function(_, bufnr)
          local map = function(keys, func)
            vim.keymap.set("n", keys, func, { noremap = true, silent = true, buffer = bufnr })
          end
          map("K", vim.lsp.buf.hover)
          map("gd", vim.lsp.buf.definition)
          map("<leader>ca", vim.lsp.buf.code_action)
        end,
        settings = {
          ["rust-analyzer"] = {
            linkedProjects = find_linked_projects(),
          },
        },
      },
    }
  end,
}
