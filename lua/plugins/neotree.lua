return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			window = {
				width = 30, -- window size
			},
			-- Add a right-side border
			default_component_configs = {
				indent = {
					padding = 1, -- Space before file names
				},
			},
		})
		-- Set highlights to define the border
		-- vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#000000" }) -- Keep background black
		-- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#000000" }) -- Non-active window background
		-- vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { bg = "#ff5555", fg = "#ffffff", bold = true }) -- Highlight title bar
		-- vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#2a2a2a", bg = "#000000" }) -- White separator line
		-- vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#2a2a2a", bold = true }) -- Dark gray but more visible

	---key binding to toggle neotree
		-- vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<cr>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>n", ":Neotree filesystem reveal left<cr>", { noremap = true, silent = true })

        --closes Neotree with Shift+Q
        vim.keymap.set("n", "Q", ":Neotree close<CR>", { noremap = true, silent = true })
	end,
}
