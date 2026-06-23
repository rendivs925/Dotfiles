return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = {
        enable_autocmd = false,
      },
    },
  },

  opts = function()
    local ts_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

    local ts_filetypes = {
      javascript = true,
      javascriptreact = true,
      typescript = true,
      typescriptreact = true,
      vue = true,
      svelte = true,
      html = true,
      css = true,
    }

    return {
      pre_hook = function(ctx)
        local ft = vim.bo.filetype

        if ts_filetypes[ft] then
          return ts_hook(ctx) or vim.bo.commentstring or "// %s"
        end

        if ft == "i3config" or ft == "swayconfig" or ft == "conf" then
          return "# %s"
        end

        return vim.bo.commentstring ~= "" and vim.bo.commentstring or "# %s"
      end,
    }
  end,

  config = function(_, opts)
    require("Comment").setup(opts)

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = {
        "*/.config/i3/config",
        "*/.i3/config",
        "*/.config/sway/config",
      },
      callback = function()
        vim.bo.filetype = "i3config"
        vim.bo.commentstring = "# %s"
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "i3config", "swayconfig", "conf" },
      callback = function()
        vim.bo.commentstring = "# %s"
      end,
    })
  end,
}
