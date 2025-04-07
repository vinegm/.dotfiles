return { -- Session Management
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = { need = 2 },
  keys = {
    {
      '<leader>qr',
      function()
        require('persistence').load()
      end,
      desc = '[R]estore [S]ession',
    },
    {
      '<leader>qs',
      function()
        require('persistence').select()
      end,
      desc = '[S]elect Session',
    },
    {
      '<leader>ql',
      function()
        require('persistence').load { last = true }
      end,
      desc = 'Restore [L]ast Session',
    },
    {
      '<leader>qd',
      function()
        require('persistence').stop()
      end,
      desc = "[D]on't Save Current Session",
    },
  },
}
