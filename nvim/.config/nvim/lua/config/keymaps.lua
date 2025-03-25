-- [[ Basic Keymaps ]]

-- Leave insert mode with double j
vim.keymap.set('i', 'jj', '<Esc>')

-- Opens Explorer
vim.keymap.set('n', '<leader>ex', vim.cmd.Ex, { desc = '[Ex]plore' })

-- Opens LazyNvim
vim.keymap.set('n', '<leader>ln', vim.cmd.Lazy, { desc = '[L]azy[N]vim' })

-- Open Mason
vim.keymap.set('n', '<leader>m', vim.cmd.Mason, { desc = '[M]ason' })

-- Clear highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Saves the chages made to the file
vim.keymap.set('n', '<C-s>', vim.cmd.w, { desc = '[S]aves the changes made in the file' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>qn', vim.diagnostic.get_next, { desc = '[Q]uickfix [N]ext Item' })
vim.keymap.set('n', '<leader>qp', vim.diagnostic.get_next, { desc = '[Q]uickfix [P]revious Item' })

-- Disable arrow keys in normal mode :<
vim.keymap.set('n', '<left>', '')
vim.keymap.set('n', '<right>', '')
vim.keymap.set('n', '<up>', '')
vim.keymap.set('n', '<down>', '')

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
