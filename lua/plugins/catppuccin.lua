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
            --uncomment for pure black------------
			-- color_overrides = {
			--     mocha = {
			--         base = "#000000",
			--         mantle = "#000000",
			--         crust = "#000000",
			--     },
			-- },
			-- custom_highlights = function(colors)
			--     return {
			--         Normal = { bg = "#000000" },
			--         NormalNC = { bg = "#000000" },
			--         SignColumn = { bg = "#000000" },
			--         VertSplit = { bg = "#000000", fg = "#000000" },
			--         StatusLine = { bg = "#000000", fg = colors.text },
			--         StatusLineNC = { bg = "#000000", fg = colors.overlay0 },
			--         WinSeparator = { fg = "#000000" },
			--         CursorLine = { bg = "#0a0a0a" },
			--     }
			-- end,

            ----------------------------------------------------------

            ----little less black--------------------------------------
			color_overrides = {
			    mocha = {
			        base = "#0d0d0d",
			        mantle = "#0d0d0d",
			        crust = "#0d0d0d",
			    },
			},
			custom_highlights = function(colors)
			    return {
			        Normal = { bg = "#0d0d0d" },
			        NormalNC = { bg = "#0d0d0d" },
			        SignColumn = { bg = "#0d0d0d" },
			        VertSplit = { bg = "#0d0d0d", fg = "#0d0d0d" },
			        StatusLine = { bg = "#0d0d0d", fg = colors.text },
			        StatusLineNC = { bg = "#0d0d0d", fg = colors.overlay0 },
			        WinSeparator = { fg = "#0d0d0d" },
			        CursorLine = { bg = "#111111" }, -- slightly lighter to stand out
			    }
			end,
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
