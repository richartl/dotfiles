return {
  {
    "nvim-tree/nvim-tree.lua",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "stevearc/dressing.nvim",
    },

    config = function()
      local api = require("nvim-tree.api")

      -- ============================================================
      -- Input flotante
      -- ============================================================

      require("dressing").setup({
        input = {
          enabled = true,
          default_prompt = "☠ ",
          trim_prompt = true,
          title_pos = "left",
          border = "single",
          relative = "cursor",
          prefer_width = 50,
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },
        },
      })

      -- ============================================================
      -- Keymaps exclusivos de NvimTree
      -- ============================================================

      local function on_attach(bufnr)
        api.config.mappings.default_on_attach(bufnr)

        local function opts(desc)
          return {
            desc = "NvimTree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end

        -- ----------------------------------------------------------
        -- Crear
        -- ----------------------------------------------------------

        vim.keymap.set(
          "n",
          "a",
          api.fs.create,
          opts("Create File / Directory")
        )

        -- ----------------------------------------------------------
        -- Eliminar
        -- ----------------------------------------------------------

        vim.keymap.set(
          "n",
          "d",
          api.fs.remove,
          opts("Delete")
        )

        -- ----------------------------------------------------------
        -- Renombrar con modal flotante
        -- ----------------------------------------------------------

        vim.keymap.set("n", "r", function()
          local node = api.tree.get_node_under_cursor()

          if not node or not node.absolute_path then
            return
          end

          local old_path = node.absolute_path
          local old_name = vim.fn.fnamemodify(old_path, ":t")
          local parent_dir = vim.fn.fnamemodify(old_path, ":h")

          vim.ui.input({
            prompt = "Rename: ",
            default = old_name,
          }, function(new_name)
            if not new_name or new_name == "" or new_name == old_name then
              return
            end

            local new_path = parent_dir .. "/" .. new_name

            local result = vim.fn.rename(old_path, new_path)

            if result ~= 0 then
              vim.notify(
                "Could not rename file",
                vim.log.levels.ERROR
              )
              return
            end

            api.tree.reload()
          end)
        end, opts("Rename"))

        -- ----------------------------------------------------------
        -- Copiar / duplicar con modal flotante
        -- ----------------------------------------------------------

        vim.keymap.set("n", "c", function()
          local node = api.tree.get_node_under_cursor()

          if not node or not node.absolute_path then
            return
          end

          local source = node.absolute_path
          local filename = vim.fn.fnamemodify(source, ":t")
          local parent_dir = vim.fn.fnamemodify(source, ":h")

          vim.ui.input({
            prompt = "Copy as: ",
            default = filename,
          }, function(new_name)
            if not new_name or new_name == "" then
              return
            end

            local destination = parent_dir .. "/" .. new_name

            if vim.fn.filereadable(destination) == 1
              or vim.fn.isdirectory(destination) == 1
            then
              vim.notify(
                "Destination already exists: " .. new_name,
                vim.log.levels.WARN
              )
              return
            end

            if node.type == "directory" then
              vim.fn.system({
                "cp",
                "-R",
                source,
                destination,
              })
            else
              vim.fn.system({
                "cp",
                source,
                destination,
              })
            end

            if vim.v.shell_error ~= 0 then
              vim.notify(
                "Could not copy: " .. filename,
                vim.log.levels.ERROR
              )
              return
            end

            api.tree.reload()
          end)
        end, opts("Copy As"))

        -- ----------------------------------------------------------
        -- Cut / Paste clásico
        -- ----------------------------------------------------------

        vim.keymap.set(
          "n",
          "x",
          api.fs.cut,
          opts("Cut")
        )

        vim.keymap.set(
          "n",
          "p",
          api.fs.paste,
          opts("Paste")
        )

        -- ----------------------------------------------------------
        -- Copiar información al clipboard
        -- ----------------------------------------------------------

        vim.keymap.set(
          "n",
          "y",
          api.fs.copy.filename,
          opts("Copy Filename")
        )

        vim.keymap.set(
          "n",
          "Y",
          api.fs.copy.relative_path,
          opts("Copy Relative Path")
        )

        -- ----------------------------------------------------------
        -- Tree
        -- ----------------------------------------------------------

        vim.keymap.set(
          "n",
          "R",
          api.tree.reload,
          opts("Refresh")
        )

        vim.keymap.set(
          "n",
          "?",
          api.tree.toggle_help,
          opts("Help")
        )
      end

      -- ============================================================
      -- NvimTree
      -- ============================================================

      require("nvim-tree").setup({
        on_attach = on_attach,

        view = {
          width = 35,
          side = "left",
        },

        renderer = {
          group_empty = true,

          highlight_git = true,
          highlight_opened_files = "name",

          icons = {
            glyphs = {
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
              },
            },

            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },

        filters = {
          dotfiles = false,
	  git_ignored = false,
        },

        git = {
          enable = true,
        },
      })

      -- ============================================================
      -- Navegación general
      -- ============================================================

      -- Ctrl+n -> abre/cierra explorer
      vim.keymap.set(
        "n",
        "<C-n>",
        "<cmd>NvimTreeToggle<CR>",
        { desc = "Toggle file explorer" }
      )

      -- Ctrl+h -> pane izquierdo
      vim.keymap.set(
        "n",
        "<C-h>",
        "<C-w>h",
        { desc = "Move left" }
      )

      -- Ctrl+l -> pane derecho
      vim.keymap.set(
        "n",
        "<C-l>",
        "<C-w>l",
        { desc = "Move right" }
      )

      -- Ctrl+j -> pane abajo
      vim.keymap.set(
        "n",
        "<C-j>",
        "<C-w>j",
        { desc = "Move down" }
      )

      -- Ctrl+k -> pane arriba
      vim.keymap.set(
        "n",
        "<C-k>",
        "<C-w>k",
        { desc = "Move up" }
      )
    end,
  },
}
