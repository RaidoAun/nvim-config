require("diffview").setup({
	enhanced_diff_hl = true,
	diffopt = { algorithm = "histogram" },
})

vim.keymap.set('n', '<leader>dv', '<cmd>DiffviewToggle<cr>', { desc = 'Toggle Diffview' })
vim.keymap.set('n', '<leader>dh', '<cmd>DiffviewFileHistory %<cr>', { desc = 'File history (current file)' })
vim.keymap.set('v', '<leader>dh', "<Esc><cmd>'<,'>DiffviewFileHistory --follow<CR>", { desc = 'Range history' })
vim.keymap.set('n', '<leader>dl', '<cmd>.DiffviewFileHistory --follow<CR>', { desc = 'Line history' })

vim.opt.fillchars:append { diff = "-" }
