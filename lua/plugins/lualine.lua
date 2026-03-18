return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    lualine.setup({
      options = {
        -- theme = 'iceberg_dark',
        theme = "onedark",
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = {
          "mode",
        },
        lualine_b = {
          -- { "branch" },
          {
            "diagnostics",
            sources = { "nvim_diagnostic", "coc" },
            sections = { "error", "warn", "info", "hint" },
            diagnostics_color = {
              error = "DiagnosticError", -- Changes diagnostics' error color.
              warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
              info = "DiagnosticInfo", -- Changes diagnostics' info color.
              hint = "DiagnosticHint", -- Changes diagnostics' hint color.
            },
            symbols = { error = "E", warn = "W", info = "I", hint = "H" },
            colored = true, -- Displays diagnostics status in color if set to true.
            update_in_insert = false, -- Update diagnostics in insert mode.
            always_visible = false, -- Show diagnostics even if there are none.
          },
        },
        lualine_c = {
          {
            "buffers",
            show_filename_only = true,
            hide_filename_extension = false,
            show_modified_status = true,
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype", "branch" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })

    vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
    vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
  end,
}
