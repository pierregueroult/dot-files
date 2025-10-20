vim.g.mapleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"
vim.opt.mouse = ""

vim.diagnostic.config({ virtual_text = true })

vim.keymap.set("n", "<leader>ws", "<cmd>split<CR>", { desc = "Horizontal split" })
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Go to left split" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Go to right split" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Go to bottom split" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Go to top split" })
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Close current split" })
vim.keymap.set("n", "<leader>wx", "<cmd>only<CR>", { desc = "Close all other splits" })
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Equalize all splits" })


