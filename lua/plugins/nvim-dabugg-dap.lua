return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"jay-babu/mason-nvim-dap.nvim",
		{
			"nvim-neotest/nvim-nio",
			lazy = true,
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Setup DAP UI
		dapui.setup()
		require("nvim-dap-virtual-text").setup()
		require("mason-nvim-dap").setup({
			ensure_installed = { "codelldb" }, -- only C/C++
			automatic_setup = true,
		})

		-- Auto open/close UI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- 🔥 C/C++ adapter (lldb via mason-codelldb)
		local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
		local codelldb_path = mason_path .. "adapter/codelldb"
		local liblldb_path = mason_path .. "lldb/lib/liblldb.dylib" -- macOS

		dap.adapters.lldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = codelldb_path,
				args = { "--liblldb", liblldb_path, "--port", "${port}" },
			},
		}

		-- Debug configs for C and C++
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
			{
				name = "Attach to process",
				type = "lldb",
				request = "attach",
				pid = require("dap.utils").pick_process,
				args = {},
			},
		}
		dap.configurations.c = dap.configurations.cpp

		-- 🎹 Keymaps (use function keys like VSCode)
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Start/Continue" })
		vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
		vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
		vim.keymap.set("n", "<F6>", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "DAP: Conditional Breakpoint" })
		vim.keymap.set("n", "<F7>", dap.repl.open, { desc = "DAP: Open REPL" })
		vim.keymap.set("n", "<F8>", dapui.toggle, { desc = "DAP: Toggle UI" })
	end,
}
