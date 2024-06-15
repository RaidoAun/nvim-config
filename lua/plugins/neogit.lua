return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed, not both.
		"nvim-telescope/telescope.nvim", -- optional
		-- "ibhagwan/fzf-lua",              -- optional
	},
	config = function()
		local neogit = require("neogit")
		neogit.setup({})
		-- local cwd = vim.fn.getcwd()
		-- vim.cmd("echomsg " .. vim.inspect(cwd))
		-- local log_file = vim.fn.stdpath("data") .. "/nvim_debug.log"
		-- local log = io.open(log_file, "a")
		-- log:write("Debug: Sample variable - " .. vim.inspect(cwd) .. "\n")
		-- log:close()

		local function find_git_repos(directory)
			local handle = io.popen("find " .. directory .. ' -type d -name ".git"')
			local result = handle:read("*a")
			handle:close()

			local repos = {}
			for path in result:gmatch("[^\r\n]+") do
				table.insert(repos, path:sub(1, #path - 5)) -- Remove '/.git' from the path
			end

			return repos
		end

		-- Cache for git repositories
		local git_repos = {}
		local current_index = 1

		-- Function to initialize the git repositories cache
		local function initialize_git_repos()
			git_repos = find_git_repos(vim.fn.getcwd())
			if #git_repos == 0 then
				vim.notify("No git repositories found in the current directory.")
			else
				current_index = 1
			end
		end

		-- Function to toggle between git repositories
		function ToggleNeogitProject()
			if #git_repos == 0 then
				initialize_git_repos()
				if #git_repos == 0 then
					return
				end
			end

			current_index = current_index % #git_repos + 1
			local repo_path = git_repos[current_index]
			vim.cmd("cd " .. repo_path)
			neogit.open()
			vim.notify("Switched to " .. repo_path)
		end

		-- Key mapping to toggle between projects
		vim.api.nvim_set_keymap("n", "<leader>gt", ":lua ToggleNeogitProject()<CR>", { noremap = true, silent = true })

		vim.keymap.set("n", "<leader>gg", function()
			neogit.open()
		end)
	end,
}
