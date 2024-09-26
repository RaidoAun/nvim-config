vim.api.nvim_create_user_command(
  'GitPrune',
  function()
    vim.cmd('!git fetch --prune')
    vim.cmd('!git branch -vv | grep ": gone]" | awk \'{print $1}\' | xargs -r git branch -d')
  end,
  {}
)
