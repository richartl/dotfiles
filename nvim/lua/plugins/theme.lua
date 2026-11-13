-- ============================================================
-- Tema: FANZINE ☠ (nvim/colors/fanzine.lua, sin plugin)
--
-- Tokyonight queda instalado pero sin cargar, como respaldo:
--   :colorscheme tokyonight-night
-- ============================================================

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.cmd.colorscheme("fanzine")
  end,
})

vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- Bordes duros en todas las ventanas flotantes.
vim.opt.winborder = "single"

return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
}
