# 📓 quicknote.nvim

> A minimal Neovim plugin to open a floating note buffer per project (or globally), perfect for jotting down todos, thoughts, or quick reminders.

![demo gif](https://your-screenshot-or-demo.gif)

---

## ✨ Features

- 📝 Floating markdown buffer
- 📂 Saves a separate note per project
- 🌍 Global fallback note if outside a project
- 💾 Autosaves when you close the window
- 🧼 Press `q` to close the note buffer
- 🧠 Header inside the note indicating if it’s project/global

---

## ⚡ Installation

### With [Lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "yourusername/quicknote.nvim",
  config = function()
    require("quicknote").setup()
  end,
}
