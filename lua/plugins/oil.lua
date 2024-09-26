return {
	'stevearc/oil.nvim',
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	config = function()
		local oil = require("oil")
		oil.setup({
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
				natural_order = true,
				is_always_hidden = function(name, _)
					return name == ".."
				end,
			},
			win_options = {
				winblend = 0,
			},
			use_default_keymaps = false,
			keymaps = {
				["?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
				["<C-s>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
				["<C-p>"] = "actions.preview",
				["q"] = "actions.close",
				["<C-r>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["s"] = "actions.change_sort",
				["."] = "actions.toggle_hidden",
			},
		})
		vim.keymap.set("n", "<leader>fe", oil.open, { desc = "[F]ile [E]xplorer" })
	end
}
