local M = {}

local function get_project_root()
  local root = vim.fs.dirname(vim.fs.find({ ".git", "pyproject.toml", "package.json" }, { upward = true })[1])
  return root or nil
end

local function get_note_path()
  local project_root = get_project_root()
  if project_root then
    return project_root .. "/.nvim-quicknote.md"
  else
    -- Fallback to a global note
    return vim.fn.stdpath("data") .. "/quicknote.md"
  end
end

local function save_to_file(buf, path)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local ok, err = pcall(function()
    vim.fn.writefile(lines, path)
  end)

  if not ok then
    vim.notify("QuickNote failed to save: " .. err, vim.log.levels.ERROR)
  end
end

function M.open()
  local note_path = get_note_path()
  local buf = vim.api.nvim_create_buf(false, true)

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  vim.bo[buf].filetype = "markdown"
  vim.bo[buf].bufhidden = "wipe"

  vim.notify(is_global and "Opened Global Note" or "Opened Project Note", vim.log.levels.INFO)

  vim.api.nvim_buf_set_option(buf, "number", true)
  vim.api.nvim_buf_set_option(buf, "relativenumber", true)

  if vim.fn.filereadable(note_path) == 1 then
    local lines = vim.fn.readfile(note_path)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  end

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(0, true)
  end, { buffer = buf, nowait = true, silent = true })

  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = buf,
    callback = function()
      save_to_file(buf, note_path)
    end,
  })
end

function M.setup()
  vim.api.nvim_create_user_command("QuickNote", function()
    M.open()
  end, {})
end

return M
