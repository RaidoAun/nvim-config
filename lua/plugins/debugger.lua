local zig_conf = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = "${workspaceFolder}",
	},
}

local go_conf = {
	{
		type = "delve",   -- Adapter type
		name = "Debug",
		request = "launch",
		program = "${file}",   -- Debug the current file
	},
	{
		type = "delve",
		name = "Debug with Args",
		request = "launch",
		program = "${file}",
		args = function()
			local input = vim.fn.input("Input args: ")
			return vim.split(input, " ")
		end,
	},
	{
		type = "delve",
		name = "Debug Package",
		request = "launch",
		program = "./${relativeFileDirname}",   -- Debug package in the current directory
	},
}

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			-- "theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			-- "williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")
			ui.setup()

			-- require("dapui").setup()
			dap.adapters.lldb = {
				type = 'executable',
				command = 'lldb',
				name = 'lldb'
			}
			dap.adapters.delve = {
				type = 'server',
				host = '127.0.0.1',
				port = 38697
			}
			-- dap.adapters.gdb = {
			-- 	type = "executable",
			-- 	command = "gdb",
			-- 	args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
			-- }

			dap.configurations.zig = zig_conf
			dap.configurations.go = go_conf

			vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
			vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

			-- Eval var under cursor
			-- vim.keymap.set("n", "<space>?", function()
			-- 	require("dapui").eval(nil, { enter = true })
			-- end)

			vim.keymap.set("n", "<F1>", dap.continue)
			vim.keymap.set("n", "<F2>", dap.step_into)
			vim.keymap.set("n", "<F3>", dap.step_over)
			vim.keymap.set("n", "<F4>", dap.step_out)
			vim.keymap.set("n", "<F5>", dap.step_back)
			vim.keymap.set("n", "<F13>", dap.restart)

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
