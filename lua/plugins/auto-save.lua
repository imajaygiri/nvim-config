return {
	"okuuva/auto-save.nvim",
	config = function()
		require("auto-save").setup({
			--      execution_message = "Auto-Saving...",
			debounce_delay = 100,
			condition = function(buf)
				-- Get the filetype of the current buffer
				local filetype = vim.api.nvim_buf_get_option(buf, "filetype")

				-- If the filetype is 'lua', return false to prevent auto-saving
				if filetype == "lua" then
					return false
				end

				-- Original condition: only save if the buffer is modifiable
				return vim.fn.getbufvar(buf, "&modifiable") == 1
			end,
		})
	end,
}

