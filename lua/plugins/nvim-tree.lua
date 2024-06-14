return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require('nvim-tree').setup {
        renderer = {
          icons = {
            glyphs = {
              default = '>',      -- default file
              symlink = '->',     -- symlink
              folder = {
                arrow_open = 'v', -- open folder arrow
                arrow_closed = '>',-- closed folder arrow
                default = '+',    -- folder
                open = 'v',       -- open folder
                empty = '-',      -- empty folder
                empty_open = 'v', -- empty open folder
                symlink = '->',   -- folder symlink
                symlink_open = 'v'-- open folder symlink
              },
              git = {
                unstaged = '!',  -- unstaged
                staged = '+',    -- staged
                unmerged = '?',  -- unmerged
                renamed = '>',   -- renamed
                untracked = '*', -- untracked
                deleted = 'x',   -- deleted
                ignored = 'i'    -- ignored
              }
            }
          }
        }
      }
      vim.api.nvim_set_keymap('n', '<leader>fe', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end
  }
}
