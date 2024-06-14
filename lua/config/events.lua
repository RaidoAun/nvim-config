local augroup = vim.api.nvim_create_augroup
local johnGroup = augroup('john', {})
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = johnGroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})
