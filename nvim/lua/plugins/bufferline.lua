return {
  {
    "akinsho/bufferline.nvim",
    version = "*",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      -- Pestañas tipo recorte: inactivas en fotocopia gris,
      -- la activa como sticker amarillo ácido.
      local ink, ink3, paper, grey = "#0b0b0b", "#2a2a2a", "#efe9dc", "#6b6b6b"
      local acid, pink, blood = "#f7e600", "#ff2a6d", "#e10600"

      local highlights = {
        fill                  = { bg = ink },
        background            = { fg = grey, bg = ink3 },
        buffer_visible        = { fg = paper, bg = ink3 },
        buffer_selected       = { fg = ink, bg = acid, bold = true, italic = false },
        separator             = { fg = ink, bg = ink3 },
        separator_visible     = { fg = ink, bg = ink3 },
        separator_selected    = { fg = ink, bg = acid },
        indicator_selected    = { fg = pink, bg = acid },
        modified              = { fg = pink, bg = ink3 },
        modified_visible      = { fg = pink, bg = ink3 },
        modified_selected     = { fg = blood, bg = acid },
        close_button          = { fg = grey, bg = ink3 },
        close_button_visible  = { fg = grey, bg = ink3 },
        close_button_selected = { fg = ink, bg = acid },
        duplicate             = { fg = grey, bg = ink3, italic = true },
        duplicate_selected    = { fg = ink, bg = acid, italic = true },
        offset_separator      = { fg = paper, bg = ink },
      }
      -- Diagnósticos: mismo fondo que la pestaña en la que aparecen.
      for _, kind in ipairs({ "diagnostic", "hint", "info", "warning", "error" }) do
        for _, suffix in ipairs({ "", "_diagnostic" }) do
          if not (kind == "diagnostic" and suffix ~= "") then
            highlights[kind .. suffix] = { bg = ink3 }
            highlights[kind .. suffix .. "_visible"] = { bg = ink3 }
            highlights[kind .. suffix .. "_selected"] = { fg = ink, bg = acid, bold = true, italic = false }
          end
        end
      end

      require("bufferline").setup({
        highlights = highlights,
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
