# 📓 quicknote.nvim

> A minimal Neovim plugin to open a floating note buffer per project (or globally), perfect for jotting down todos, thoughts, or quick reminders.

---

## ✨ Features

- 📝 Floating markdown buffer
- 📂 Saves a separate note per project
- 🌍 Global fallback note if outside a project
- 💾 Autosaves when you close the window
- 🧼 Press `q` to close the note buffer

---

## ⚡ Installation

### With [Lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "584973/quicknote.nvim",
  config = function()
    require("quicknote").setup()
  end,
}
