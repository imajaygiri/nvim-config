-- vim.cmd("set expandtab")
-- vim.cmd("set tabstop=4")
-- vim.cmd("set softtabstop=4")
-- vim.cmd("set shiftwidth=4")

vim.opt.tabstop = 4 -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4 -- Number of spaces to use for autoindent
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.softtabstop = 4 -- Makes backspacing behave as expected
-- Prevent 'dd' from using the system clipboard
vim.opt.clipboard = ""

-- Map Shift+Y (Y) to copy to the system clipboard
vim.api.nvim_set_keymap("n", "Y", '"+y$', { noremap = true, silent = true })
-- Map Shift+Y (Y) in visual mode to copy the selected text to the system clipboard
vim.api.nvim_set_keymap("v", "Y", '"+y', { noremap = true, silent = true })

--key binding for markdowm preview
vim.api.nvim_set_keymap("n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { noremap = true, silent = true })

vim.o.updatetime = 200 -- Reduce delay for CursorHold to trigger faster
