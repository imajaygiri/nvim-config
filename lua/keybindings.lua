local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
-- map('n', "<leader>t" ,":terminal<CR>" ,opts);
map("n", "<C-n>", ":nohlsearch<CR>", opts)
map("i", "<C-H>", "<C-W>", opts)
map("i", "<C-BS>", "<C-W>", opts)
map("n", "<leader>bn", ":bnext<CR>", opts)
map("n", "<leader>bp", ":bprevious<CR>", opts)
map("n", "<leader>bd", ":bd<CR>", opts)
map("n", "<leader>bD", ":%bd|e#|bd#<CR>", opts)
map("n", "<leader>bb", ":Telescope buffers<CR>", opts)
map("n", "<leader>p", '"+p', opts)

-- keybinding-neoclip

map("n", "<leader>cb", ":Telescope neoclip<CR>", opts)
--mouse on
vim.o.mouse = "a"
----remaping ctrl-u and d with j and k --half page scroll-----
vim.keymap.set("n", "<C-j>", "<C-d>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-u>", { noremap = true, silent = true })

