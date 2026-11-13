return {
  {
    "akinsho/bufferline.nvim",
    version = "*",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",

          numbers = "none",

          separator_style = "slant",

          show_buffer_close_icons = true,
          show_close_icon = false,

          diagnostics = "nvim_lsp",

          offsets = {
            {
              filetype = "NvimTree",
              text = "  EXPLORER",
              highlight = "Directory",
              separator = true,
            },
          },
        },
      })

      -- ======================================================
      -- Navegación de buffers
      -- ======================================================

      -- Tab -> siguiente buffer
      vim.keymap.set(
        "n",
        "<Tab>",
        "<cmd>BufferLineCycleNext<CR>",
        { desc = "Next buffer" }
      )

      -- Shift+Tab -> buffer anterior
      vim.keymap.set(
        "n",
        "<S-Tab>",
        "<cmd>BufferLineCyclePrev<CR>",
        { desc = "Previous buffer" }
      )


      -- ======================================================
      -- Cerrar buffer
      -- ======================================================

      local function close_current_buffer()
        local current = vim.api.nvim_get_current_buf()

        -- Obtener buffers abiertos y válidos
        local buffers = vim.tbl_filter(function(buf)
          return vim.api.nvim_buf_is_valid(buf)
            and vim.bo[buf].buflisted
        end, vim.api.nvim_list_bufs())

        -- Si hay más de un buffer, cambiar primero a otro
        if #buffers > 1 then
          vim.cmd("bprevious")
        else
          -- Si es el último buffer, crear uno vacío
          vim.cmd("enew")
        end

        -- Eliminar únicamente el buffer anterior
        local ok, err = pcall(
          vim.api.nvim_buf_delete,
          current,
          { force = false }
        )

        if not ok then
          vim.notify(
            "No se pudo cerrar el buffer: " .. tostring(err),
            vim.log.levels.WARN
          )
        end
      end


      -- Ctrl+X -> cerrar únicamente el buffer actual
      vim.keymap.set(
        "n",
        "<C-x>",
        close_current_buffer,
        { desc = "Close current buffer" }
      )


      -- Leader + bd -> mismo comportamiento
      vim.keymap.set(
        "n",
        "<leader>bd",
        close_current_buffer,
        { desc = "Close current buffer" }
      )
    end,
  },
}
