return {
  {
    "stevearc/dressing.nvim",

    config = function()
      require("dressing").setup({
        input = {
          enabled = true,
          default_prompt = "➤ ",
          trim_prompt = true,
          title_pos = "left",

          border = "rounded",

          relative = "cursor",

          prefer_width = 50,
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },
        },
      })
    end,
  },
}
