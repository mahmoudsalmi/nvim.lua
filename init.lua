require("config.lazy")

vim.opt.shiftwidth = 4
-- vim.opt.clipboard = "unnamedPlus"

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (coping) text',
  group = vim.api.nvim_create_augroup('ms-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
