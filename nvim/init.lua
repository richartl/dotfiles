-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

vim.keymap.set(
  { "n", "i", "v" },
  "<C-z>",
  "<Nop>",
  { desc = "Disable accidental suspend" }
)

require("config.lazy")
