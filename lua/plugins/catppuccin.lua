return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
         require("catppuccin").setup({
             flavour = "mocha", -- Use the darkest variant
             background = {
                 light = "latte",
                 dark = "macchiato",
             },
             color_overrides = {
                 mocha = {
                     base = "#000000",
                     mantle = "#000000",
                     crust = "#000000",
                 },
             },
             custom_highlights = function(colors)
                 return {
                     Normal = { bg = "#000000" },
                     NormalNC = { bg = "#000000" },
                     SignColumn = { bg = "#000000" },
                     VertSplit = { bg = "#000000", fg = "#000000" },
                     StatusLine = { bg = "#000000", fg = colors.text },
                     StatusLineNC = { bg = "#000000", fg = colors.overlay0 },
                     WinSeparator = { fg = "#000000" },
                     CursorLine = { bg = "#0a0a0a" },
                 }
             end,
         })

         vim.cmd.colorscheme("catppuccin")
     end,
 }

