local M = {}

local function resolve_path(filename, cwd)
  local normalized = filename:match("^%./(.+)$") or filename
  if normalized:sub(1, 1) == "/" then
    return normalized
  end
  return cwd .. "/" .. normalized
end

local function parse_lines(lines)
  local entries = {}
  local cwd = vim.fn.getcwd()

  for _, line in ipairs(lines) do
    local filename, lnum, col = line:match("([%w%./_%-]+%.%w+):(%d+):(%d+)")
    if not filename then
      filename, lnum = line:match("([%w%./_%-]+%.%w+):(%d+)")
    end
    if filename then
      local abs_path = resolve_path(filename, cwd)
      -- Skip if file doesn't exist (filters out IP addresses, error tracebacks, etc.)
      if vim.fn.filereadable(abs_path) == 1 then
        table.insert(entries, {
          filename = abs_path,
          lnum = tonumber(lnum),
          col = col and tonumber(col),
        })
      end
    end
  end

  return entries
end

function M.extract_to_qflist()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "buftype", "acwrite")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_name(buf, "PasteLog")

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    "Paste error output below, then press <Esc> to extract file:line references",
    "──────────────────────────────────────────────────────────────────────────",
  })

  vim.api.nvim_create_autocmd("InsertLeave", {
    buffer = buf,
    once = true,
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(buf, 2, -1, false)
      local entries = parse_lines(lines)
      vim.api.nvim_buf_delete(buf, { force = true })

      if #entries == 0 then
        vim.notify("No file:line references found", vim.log.levels.WARN)
        return
      end

      vim.fn.setqflist({}, " ", { items = entries, title = "Extracted Locations" })
      vim.cmd("copen")
    end,
  })

  vim.api.nvim_set_current_buf(buf)
  vim.cmd("startinsert!")
end

return M
