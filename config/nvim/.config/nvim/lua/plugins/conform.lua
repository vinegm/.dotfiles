local function prettier_config()
  local config_path = vim.fn.getcwd() .. "/.prettierrc"
  if vim.fn.filereadable(config_path) == 1 then
    return { "--config", config_path }
  else
    return {}
  end
end

return { -- Autoformat
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    notify_on_error = true,
    format_on_save = false,
    formatters_by_ft = {
      bash = { "shfmt" },
      javascript = { "prettierd", "prettier" },
      javascriptreact = { "prettierd", "prettier" },
      lua = { "stylua" },
      typescript = { "prettierd", "prettier" },
      python = { "black" },
    },
    formatters = {
      prettier = {
        prepend_args = prettier_config,
      },
      prettierd = {
        prepend_args = prettier_config,
      },
    },
  },

  keys = {
    {
      "<a-s>",
      vim.cmd.w,
      desc = "[Alt]ernate [S]ave file (without formatting)",
    },
    {
      "<C-s>",
      function()
        require("conform").format({ async = true, lsp_fallback = true }, function() vim.cmd.w() end)
      end,
      desc = "[S]ave file (w\\formatting)",
    },
    {
      "<leader>f",
      function() require("conform").format({ async = true, lsp_fallback = true }) end,
      desc = "[F]ormat file",
    },
  },
}
