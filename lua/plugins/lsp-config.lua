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
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Ensure we are on a version that supports vim.lsp.config (Nvim 0.11+)
			-- If you get an error here, you might need to update Neovim to Nightly.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- ✅ Disable formatting from some LSPs
			local on_attach = function(client, _)
				if client.name == "html" or client.name == "cssls" or client.name == "emmet_ls" then
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end
			end

			-- Helper to set up a server using the new Nvim 0.11+ Native API
			local function setup(server, opts)
				opts = opts or {}
				opts.capabilities = capabilities
				opts.on_attach = on_attach
				-- Assign config and enable the server
				vim.lsp.config[server] = opts
				vim.lsp.enable(server)
			end

			-- Lua
			setup("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			-- Docker
			setup("dockerls", {})

			-- YAML
			setup("yamlls", {})

			-- Rust
			setup("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						inlayHints = {
							bindingModeHints = { enable = false },
							chainingHints = { enable = true },
							closingBraceHints = { enable = true, minLines = 25 },
							closureReturnTypeHints = { enable = "never" },
							lifetimeElisionHints = { enable = "never", useParameterNames = false },
							maxLength = 25,
							parameterHints = { enable = true },
							reborrowHints = { enable = "never" },
							renderColons = true,
							typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
						},
					},
				},
			})

			-- C/C++
			setup("clangd", {})

			-- Solidity
			setup("solidity_ls_nomicfoundation", {
				filetypes = { "solidity" },
				-- Native root detection for Nvim 0.11+
				root_markers = { "hardhat.config.js", "hardhat.config.ts", "foundry.toml", ".git" },
			})

			-- Java (optional if using jdtls separately)
			setup("jdtls", {})

			-- Python
			setup("pyright", {})

			-- Assembly
			setup("asm_lsp", {})

			-- CSS
			setup("cssls", {
				filetypes = { "css", "scss", "less", "html" },
				settings = {
					css = { validate = true },
					scss = { validate = true },
					less = { validate = true },
					provideFormatter = true,
				},
			})

			-- Tailwind
			setup("tailwindcss", {})

			-- HTML
			setup("html", {
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
			setup("emmet_ls", {
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
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

			-- Toggle floating diagnostic err
			local diagnostics_hidden = false
			vim.keymap.set("n", "<leader>td", function()
				diagnostics_hidden = not diagnostics_hidden
				if diagnostics_hidden then
					-- Modern way to disable diagnostics for current buffer
					vim.diagnostic.enable(false, { bufnr = 0 })
					print("🔕 Diagnostics hidden")
				else
					vim.diagnostic.enable(true, { bufnr = 0 })
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
