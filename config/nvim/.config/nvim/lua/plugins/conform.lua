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
  keys = {
    {
      "<leader>f",
      function() require("conform").format({ async = true, lsp_fallback = true }) end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
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
}
