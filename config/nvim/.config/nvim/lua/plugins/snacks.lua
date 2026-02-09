return { -- A lot of QOL
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    indent = {
      enabled = true,
      animate = {
        enabled = false,
      },
    },

    image = {},

    explorer = {},
    picker = {
      win = {
        input = {
          keys = {
            ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
          },
        },
      },

      sources = {
        files = {
          hidden = true,
          ignored = false,
        },

        explorer = {
          auto_close = true,
        },
      },
    },

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
          { icon = " ", key = "f", desc = "Find File", action = function() Snacks.picker.files() end },
          { icon = " ", key = "r", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "ln", desc = "LazyNvim", action = ":Lazy" },
          { icon = " ", key = "lg", desc = "LazyGit", action = function() Snacks.lazygit() end },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },

  keys = {
    { "<leader><leader>", function() Snacks.picker.recent() end, desc = "Search recent files" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "[S]earch [D]iagnostics" },
    { "<leader>sf", function() Snacks.picker.files() end, desc = "[S]earch [F]iles" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "[S]earch by [G]rep" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "[H]ighlights" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]eymaps" },
    { "<leader>u", function() Snacks.picker.undo() end, desc = "[U]ndo History" },

    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "[G]oto [D]efinition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "[G]oto [D]eclaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },

    { "<leader>ex", function() Snacks.explorer() end, desc = "[EX]plorer" },

    { "<leader>lg", function() Snacks.lazygit() end, desc = "[L]azy[G]it" },
    { "<leader>gh", function() Snacks.lazygit.log_file() end, desc = "[G]it file [H]istory" },
  },
}
