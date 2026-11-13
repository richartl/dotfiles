return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,

    config = function()
      require("tokyonight").setup({
        style = "night",

        transparent = false,

        terminal_colors = true,

        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { bold = true },
          variables = {},
        },

        sidebars = {
          "qf",
          "help",
          "terminal",
          "NvimTree",
        },

        on_highlights = function(hl, c)
          hl.CursorLine = {
            bg = c.bg_highlight,
          }

          hl.Visual = {
            bg = c.bg_visual,
          }

          hl.NvimTreeFolderName = {
            fg = c.blue,
            bold = true,
          }

          hl.NvimTreeOpenedFolderName = {
            fg = c.cyan,
            bold = true,
          }

          hl.NvimTreeRootFolder = {
            fg = c.magenta,
            bold = true,
          }
        end,
      })

      vim.cmd.colorscheme("tokyonight-night")
      vim.opt.cursorline = true
      vim.opt.termguicolors = true
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.signcolumn = "yes"
    end,
  },
}
