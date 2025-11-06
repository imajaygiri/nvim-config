-- Plugin (Lazy.nvim)
return {
	"NvChad/nvim-colorizer.lua",
	opts = {
		filetypes = { "*" },
		user_default_options = {
			tailwind = true,
			css = true,
			names = true,
			mode = "background", -- or 'foreground'
		},
	},
	config = function(_, opts)
		require("colorizer").setup(opts)
	end,
}
