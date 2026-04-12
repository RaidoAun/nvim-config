require('nvim-treesitter').install { 'bash', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' }

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'zig', 'zon', 'lua' },
	callback = function()
		vim.treesitter.start()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
