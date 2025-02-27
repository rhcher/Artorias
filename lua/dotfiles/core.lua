-- [nfnl] Compiled from fnl/dotfiles/core.fnl by https://github.com/Olical/nfnl, do not edit.
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.sessionoptions = "blank,curdir,folds,help,tabpages,winsize"
vim.opt.jumpoptions = "stack"
vim.opt.pumheight = 10
vim.opt.exrc = true
vim.opt.termsync = true
vim.opt.smoothscroll = true
vim.cmd.colorscheme("srcery")
vim.opt.textwidth = 100
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true
vim.opt.numberwidth = 2
vim.opt.signcolumn = "yes"
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.incsearch = false
vim.cmd("set diffopt+=linematch:800,algorithm:patience")
if (vim.fn.executable("rg") == 1) then
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
  vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
else
end
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.hidden = true
vim.opt.updatetime = 50
vim.opt.clipboard = "unnamedplus"
vim.opt.laststatus = 3
vim.opt.redrawtime = 150
vim.opt.listchars = {nbsp = "\226\166\184", extends = "\194\187", precedes = "\194\171", tab = "->", trail = "\226\128\162"}
vim.opt.fillchars = "eob: ,fold: ,foldopen:\239\145\188,foldsep: ,foldclose:\239\145\160"
vim.opt.fillchars:append({diff = "\226\149\177"})
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.splitkeep = "screen"
vim.opt.winwidth = 10
vim.opt.winminwidth = 10
vim.opt.equalalways = false
vim.cmd("filetype plugin indent on")
vim.opt.list = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.lispoptions = "expr:1"
do
  local group = vim.api.nvim_create_augroup("init", {clear = true})
  vim.api.nvim_create_autocmd({"CmdWinEnter"}, {buffer = 0, command = "cmap q <C-W>q", group = group})
  local function _2_()
    return vim.highlight.on_yank({highlight = "Visual", timeout = 150, on_visual = true})
  end
  vim.api.nvim_create_autocmd({"TextYankPost"}, {callback = _2_, group = group})
  vim.api.nvim_create_autocmd({"FocusGained", "TermClose", "TermLeave"}, {command = "checktime", group = group})
  local function _3_()
    vim.opt.formatoptions = (vim.opt.formatoptions - "o")
    return nil
  end
  vim.api.nvim_create_autocmd({"BufEnter"}, {callback = _3_, group = group})
  vim.api.nvim_create_autocmd({"FileType"}, {pattern = "cpp", command = "set cinkeys-=:", group = group})
  local function _4_()
    vim.b.snacks_indent = false
    return nil
  end
  vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"fennel", "markdown"}, callback = _4_, group = group})
  vim.api.nvim_create_autocmd({"WinClosed"}, {nested = true, command = "if expand('<amatch>') == win_getid() | wincmd p | endif", group = group})
end
if (vim.fn.has("nvim-0.11") == 1) then
  local expand_orig = vim.snippet.expand
  vim.snippet.expand = function(...)
    local tab_map = vim.fn.maparg("<Tab>", "i", false, true)
    local stab_map = vim.fn.maparg("<S-Tab>", "i", false, true)
    expand_orig(...)
    local function _5_()
      tab_map.buffer, stab_map.buffer = 1, 1
      vim.fn.mapset("i", false, tab_map)
      return vim.fn.mapset("i", false, stab_map)
    end
    return vim.schedule(_5_)
  end
else
end
if vim.g.neovide then
  vim.g.neovide_confirm_quit = false
  vim.g.neovide_fullscreen = true
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_unlink_border_highlights = true
  return nil
else
  return nil
end
