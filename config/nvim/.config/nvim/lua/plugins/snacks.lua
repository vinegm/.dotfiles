return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    indent = { enabled = true },

    notifier = {
      enabled = true,
      timeout = 3000,
      top_down = true,
    },

    dashboard = {
      preset = {
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
 ]],
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = "<cmd>Telescope find_files<CR>" },
          { icon = " ", key = "r", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "ln", desc = "LazyNvim", action = ":Lazy" },
          { icon = " ", key = "lg", desc = "LazyGit", action = "<cmd>LazyGit<CR>" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },

  keys = {
    {
      "<leader>lg",
      function() Snacks.lazygit() end,
      desc = "[L]azy[G]it",
    },
    {
      "<leader>gh",
      function() Snacks.lazygit.log_file() end,
      desc = "[G]it file [H]istory",
    },
  },
}
