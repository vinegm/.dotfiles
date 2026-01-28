return { -- shows open buffers at the top
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        show_buffer_close_icons = false,

        numbers = "ordinal",
        indicator = { style = "underline" },

        max_name_length = 10,

        right_mouse_command = nil,
        middle_mouse_command = "bdelete! %d",

        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },

        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          if level:match("error") then return " " .. count end

          return " " .. count
        end,
        custom_filter = function(buf_number, _)
          if vim.bo[buf_number].buftype ~= "terminal" then return true end
        end,
      },
    })

    vim.keymap.set("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>", { silent = true, desc = "Jump to buffer [1]" })
    vim.keymap.set("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>", { silent = true, desc = "Jump to buffer [2]" })
    vim.keymap.set("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>", { silent = true, desc = "Jump to buffer [3]" })
    vim.keymap.set("n", "<A-4>", ":BufferLineGoToBuffer 4<CR>", { silent = true, desc = "Jump to buffer [4]" })
    vim.keymap.set("n", "<A-5>", ":BufferLineGoToBuffer 5<CR>", { silent = true, desc = "Jump to buffer [5]" })
    vim.keymap.set("n", "<A-6>", ":BufferLineGoToBuffer 6<CR>", { silent = true, desc = "Jump to buffer [6]" })
    vim.keymap.set("n", "<A-7>", ":BufferLineGoToBuffer 7<CR>", { silent = true, desc = "Jump to buffer [7]" })
    vim.keymap.set("n", "<A-8>", ":BufferLineGoToBuffer 8<CR>", { silent = true, desc = "Jump to buffer [8]" })
    vim.keymap.set("n", "<A-9>", ":BufferLineGoToBuffer 9<CR>", { silent = true, desc = "Jump to buffer [9]" })
    vim.keymap.set("n", "<leader>bn", ":BufferLineCycleNext<CR>", { silent = true, desc = "[B]uffer [N]ext" })
    vim.keymap.set("n", "<leader>bl", ":BufferLineCycleNext<CR>", { silent = true, desc = "[B]uffer Next" })
    vim.keymap.set("n", "<leader>bp", ":BufferLineCyclePrev<CR>", { silent = true, desc = "[B]uffer [P]revious" })
    vim.keymap.set("n", "<leader>bh", ":BufferLineCyclePrev<CR>", { silent = true, desc = "[B]uffer Previous" })
  end,
}
