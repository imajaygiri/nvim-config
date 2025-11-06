return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- Lua
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.asmfmt,
				-- -- Web (JS, TS, HTML, CSS, etc.)
				-- null_ls.builtins.formatting.prettier.with({
				-- 	extra_args = { "--config", os.getenv("HOME") .. "/.prettierrc" },
				-- }),
				null_ls.builtins.formatting.prettier.with({
					extra_filetypes = { "solidity" },
				}),
				null_ls.builtins.formatting.prettier,
				-- null_ls.builtins.formatting.eslint,
				-- null_ls.builtins.diagnostics.eslint,
				-- null_ls.builtins.code_actions.eslint,
				-- -- C/C++
				null_ls.builtins.formatting.clang_format,
				-- -- Shell
				null_ls.builtins.formatting.shfmt,
				-- rust
				-- null_ls.builtins.formatting.ast_grep,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
