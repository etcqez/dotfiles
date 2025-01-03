vim.cmd("set ttimeout")
vim.cmd("set ttimeoutlen=100")
vim.cmd("set display=truncate")
vim.cmd("set clipboard=unnamedplus")
vim.cmd("set number")
vim.cmd("set ruler") vim.cmd("set linebreak")
vim.cmd("set showcmd")
vim.cmd("set noshowmode")
vim.cmd("set scrolloff=5")
vim.cmd("set noswapfile")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set expandtab")
vim.cmd("set splitbelow")
vim.cmd("set splitright")
vim.cmd("set hlsearch")
vim.cmd("set ignorecase")
vim.cmd("set incsearch")
vim.cmd("set smartcase")
vim.cmd("syntax on")
vim.cmd("filetype indent plugin on")
vim.cmd("inoremap <C-g> <Esc>")
vim.cmd("inoremap <C-s> <Esc>:w<Enter>")
vim.cmd("inoremap <C-d> <C-a>")
vim.cmd("noremap <C-s> :w<Enter>")
vim.cmd("inoremap <C-Enter> <Esc>o")
vim.cmd("inoremap <C-v> <Esc>o<Esc>p")
vim.cmd("inoremap <C-f> <Right>")
vim.cmd("inoremap <C-b> <Left>")
vim.cmd("inoremap <C-p> <Up>")
vim.cmd("inoremap <C-n> <Down>")
vim.cmd("inoremap <C-a> <Esc>I")
vim.cmd("inoremap <C-e> <End>")
vim.cmd("inoremap <C-t> <Esc>hxpa")
vim.cmd("inoremap <C-y> <Esc>p")
vim.cmd("noremap <C-e> <C-x>")
vim.cmd("map <C-j> <C-W>j")
vim.cmd("map <C-k> <C-W>k")
vim.cmd("map <C-h> <C-W>h")
vim.cmd("map <C-l> <C-W>l")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.cmd([[ set noswapfile ]])
vim.cmd([[ set termguicolors ]])

--Line numbers
vim.wo.number = true


vim.keymap.set("i", "<C-a>", "<Home>")
vim.keymap.set("i", "<C-e>", "<End>")
vim.keymap.set("i", "<C-b>", "<Left>")
vim.keymap.set("i", "<C-f>", "<Right>")
vim.keymap.set("i", "<C-n>", "<Up>")
vim.keymap.set("i", "<C-p>", "<Down>")
vim.keymap.set("i", "<M-b>", "<C-Left>")
vim.keymap.set("i", "<M-f>", "<C-Right>")
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-e>", "<End>")
vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-f>", "<Right>")
vim.keymap.set("c", "<M-b>", "<C-Left>")
vim.keymap.set("c", "<M-f>", "<C-Right>")

-- nvim打开文件光标自动恢复之前位置
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})
--
-- -- 设置撤销持久化目录
-- vim.o.undodir = vim.fn.stdpath('/tmp/undodir')
-- -- 启用撤销文件
-- vim.o.undofile = true

-- 检查并创建撤销目录
if not vim.loop.fs_stat('/tmp/nvim_undo') then
  vim.fn.mkdir('/tmp/nvim_undo', 'p')
end

-- 设置撤销目录
vim.o.undodir = '/tmp/nvim_undo'

-- 启用撤销持久化
vim.o.undofile = true
vim.o.undolevels = 1000  -- 设置撤销历史的最大深度
vim.o.undoreload = 10000  -- 设置撤销历史加载超时

-- 粘贴多次，必须在v模式
vim.cmd("vnoremap p pgvy")
