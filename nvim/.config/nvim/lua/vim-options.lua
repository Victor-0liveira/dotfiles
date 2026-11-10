vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
-- Copiar para a área de transferência com Ctrl + C
vim.keymap.set('n', '<C-c>', '"+y', { noremap = true, silent = true }) -- Modo normal
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, silent = true }) -- Modo visual

-- Colar do clipboard com Ctrl + V
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true, silent = true }) -- Modo normal

-- 'vie' para selecionar todo o texto no modo visual
vim.api.nvim_set_keymap('n', 'vie', 'ggVG', { noremap = true, silent = true })

-- 'die' para deletar todo o texto no buffer
vim.api.nvim_set_keymap('n', 'die', 'ggdG', { noremap = true, silent = true })


vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true
