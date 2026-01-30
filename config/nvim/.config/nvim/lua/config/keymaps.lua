-- [[ Basic Keymaps ]]

-- Leave insert mode with double j
vim.keymap.set("i", "jj", "<Esc>")

-- netrw explorer (migrated to snacks.explorer)
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex, { desc = "[Ex]plore" })

-- Opens LazyNvim
vim.keymap.set("n", "<leader>ln", vim.cmd.Lazy, { desc = "[L]azy[N]vim" })

-- Open Mason
vim.keymap.set("n", "<leader>m", vim.cmd.Mason, { desc = "[M]ason" })

-- Clear highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Quit nvim
vim.keymap.set("n", "<C-q>", vim.cmd.q, { desc = "[Q]uit Nvim" })

-- Disable arrow keys in normal mode :<
vim.keymap.set("n", "<left>", "")
vim.keymap.set("n", "<right>", "")
vim.keymap.set("n", "<up>", "")
vim.keymap.set("n", "<down>", "")

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Goes to the clipboard on leader yank
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Deletes the current buffer
vim.keymap.set("n", "<leader>bd", vim.cmd.bd, { desc = "Current [B]buffer [D]elete" })
