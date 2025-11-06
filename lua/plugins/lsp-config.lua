return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				auto_install = true,
				ensure_installed = {
					"lua_ls",
					"clangd",
					"jdtls",
					"pyright",
					"cssls",
					"tailwindcss",
					"emmet_ls",
					"html",
					"ts_ls",
					"eslint",
					"rust_analyzer",
					"dockerls",
					"yamlls",
					"asm_lsp",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- ✅ Disable formatting from some LSPs
			local on_attach = function(client, bufnr)
				if client.name == "html" or client.name == "cssls" or client.name == "emmet_ls" then
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end
			end
			-- Lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			-- docker
			lspconfig.dockerls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			-- yaml
			lspconfig.yamlls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			--rust
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					["rust-analyzer"] = {
						inlayHints = {
							bindingModeHints = {
								enable = false,
							},
							chainingHints = {
								enable = true,
							},
							closingBraceHints = {
								enable = true,
								minLines = 25,
							},
							closureReturnTypeHints = {
								enable = "never",
							},
							lifetimeElisionHints = {
								enable = "never",
								useParameterNames = false,
							},
							maxLength = 25,
							parameterHints = {
								enable = true,
							},
							reborrowHints = {
								enable = "never",
							},
							renderColons = true,
							typeHints = {
								enable = true,
								hideClosureInitialization = false,
								hideNamedConstructor = false,
							},
						},
					},
				},
			})
			-- C/C++

			lspconfig.clangd.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- cmake

			-- lspconfig.cmake.setup({
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- 	cmd = { "cmake-language-server" },
			-- 	filetypes = { "cmake" },
			-- 	root_dir = lspconfig.util.root_pattern("CMakeLists.txt", ".git"),
			-- })

			-- solidity
			lspconfig.solidity_ls_nomicfoundation.setup({
				-- cmd = { mason_path, "--stdio" },
				filetypes = { "solidity" },
				root_dir = function(fname)
					return lspconfig.util.root_pattern("hardhat.config.*", "foundry.toml", ".git")(fname)
						or lspconfig.util.path.dirname(fname)
				end,
				capabilities = capabilities,
				on_attach = on_attach,
			})
			-- javasciprt server
			-- lspconfig.ts_ls.setup({
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- })

			-- Java (optional if using jdtls separately)
			lspconfig.jdtls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Python
			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Assembly
			lspconfig.asm_lsp.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- CSS
			lspconfig.cssls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					css = { validate = true },
					scss = { validate = true },
					less = { validate = true },
					provideFormatter = true,
				},
				filetypes = { "css", "scss", "less", "html" },
			})

			-- Tailwind
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- HTML
			lspconfig.html.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "html", "htm", "handlebars" },
				settings = {
					html = {
						suggest = {
							html5 = true,
							classAttribute = true,
							styleAttribute = true,
						},
					},
				},
			})

			-- Emmet
			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "html", "css", "javascriptreact", "typescriptreact", "htm", "handlebars" },
				settings = {
					html = {
						options = {
							["bem.enabled"] = true,
						},
					},
				},
			})

			-- LSP Keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			-- 💡 Optional: show diagnostic popup manually
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			-- vim.keymap.set("n", "<leader>ld", require("telescope.builtin").diagnostic, { desc = "List Diagnostics" })

			-- Toggle floating diagnostic err
			local diagnostics_hidden = false
			vim.keymap.set("n", "<leader>td", function()
				diagnostics_hidden = not diagnostics_hidden
				if diagnostics_hidden then
					vim.diagnostic.disable(0)
					print("🔕 Diagnostics hidden")
				else
					vim.diagnostic.enable(0)
					print("🔔 Diagnostics shown")
				end
			end, { desc = "Toggle diagnostics display" })

			--  Enable diagnostics
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
			-- Auto floating diagnostics on cursor hold
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					vim.diagnostic.open_float(nil, {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "rounded",
						source = "always",
						prefix = " ",
						scope = "cursor",
					})
				end,
			})
		end,
	},
}
