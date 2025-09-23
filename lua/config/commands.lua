vim.api.nvim_create_user_command(
  'GitPrune',
  function()
    vim.cmd('!git fetch --prune')
    vim.cmd('!git branch -vv | grep ": gone]" | awk \'{print $1}\' | xargs -r git branch -d')
  end,
  {}
)

vim.api.nvim_create_user_command(
  'GitPruneD',
  function()
    vim.cmd('!git fetch --prune')
    vim.cmd('!git branch -vv | grep ": gone]" | awk \'{print $1}\' | xargs -r git branch -D')
  end,
  {}
)

vim.api.nvim_create_user_command('WipeReg', function()
    for i = 97, 122 do
        vim.fn.setreg(vim.fn.nr2char(i), {})
    end
    for i = 0, 9 do
        vim.fn.setreg(i, {})
    end
end, {})
