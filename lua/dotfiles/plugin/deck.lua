-- [nfnl] Compiled from fnl/dotfiles/plugin/deck.fnl by https://github.com/Olical/nfnl, do not edit.
local deck = require("deck")
require("deck.easy").setup()
local function _1_(e)
  local ctx = e.data.ctx
  ctx.keymap("n", "<CR>", deck.action_mapping("choose_action"))
  ctx.keymap("n", "<C-l>", deck.action_mapping("refresh"))
  ctx.keymap("n", "i", deck.action_mapping("prompt"))
  ctx.keymap("n", "a", deck.action_mapping("prompt"))
  ctx.keymap("n", "<Tab>", deck.action_mapping("toggle_select"))
  ctx.keymap("n", "*", deck.action_mapping("toggle_select_all"))
  ctx.keymap("n", "p", deck.action_mapping("toggle_preview_mode"))
  ctx.keymap("n", "d", deck.action_mapping("delete"))
  ctx.keymap("n", "o", deck.action_mapping("open"))
  ctx.keymap("n", "O", deck.action_mapping("open_keep"))
  ctx.keymap("n", "s", deck.action_mapping("open_split"))
  ctx.keymap("n", "v", deck.action_mapping("open_vsplit"))
  ctx.keymap("n", "N", deck.action_mapping("create"))
  ctx.keymap("n", "w", deck.action_mapping("write"))
  ctx.keymap("n", "<C-u>", deck.action_mapping("scroll_preview_up"))
  ctx.keymap("n", "<C-d>", deck.action_mapping("scroll_preview_down"))
  local function _2_()
    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", true)
    local function _3_()
      return ctx.do_action("default")
    end
    return vim.schedule(_3_)
  end
  ctx.keymap("c", "<C-y>", _2_)
  local function _4_()
    return ctx.set_cursor((ctx.get_cursor() + 1))
  end
  ctx.keymap("c", "<C-n>", _4_)
  local function _5_()
    return ctx.set_cursor((ctx.get_cursor() - 1))
  end
  ctx.keymap("c", "<C-p>", _5_)
  ctx.keymap("n", "q", ctx.hide)
  ctx.keymap("n", "<Esc>", ctx.hide)
  ctx.keymap("n", "<C-c>", ctx.hide)
  local function _6_()
    return vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", "true")(vim.schedule(ctx.hide))
  end
  return ctx.keymap("c", "<C-c>", _6_)
end
vim.api.nvim_create_autocmd("User", {callback = _1_, pattern = "DeckStart"})
vim.keymap.set("n", "<Leader>ff", "<Cmd>Deck files<CR>", {desc = "Show recent files, buffers, and more"})
vim.keymap.set("n", "<Leader>gr", "<Cmd>Deck grep<CR>", {desc = "Start grep search"})
vim.keymap.set("n", "<Leader>gi", "<Cmd>Deck git<CR>", {desc = "Open git launcher"})
vim.keymap.set("n", "<Leader>he", "<Cmd>Deck helpgrep<CR>", {desc = "Live grep all help tags"})
local function _7_()
  local ctx = deck.get_history()[1]
  if ctx then
    return ctx.show()
  else
    return nil
  end
end
vim.keymap.set("n", "<Leader>;", _7_)
local function _9_()
  local ctx = deck.get_history()[1]
  if ctx then
    ctx.set_cursor((ctx.get_cursor() + 1))
    return ctx.do_action("default")
  else
    return nil
  end
end
vim.keymap.set("n", "<Leader>n", _9_)
local function _11_()
  vim.wo.cursorline = true
  vim.o.signcolumn = "yes:1"
  vim.o.statuscolumn = "%=%s"
  if (vim.o.cmdheight == 0) then
    vim.o.cmdheight = 1
    local function _12_()
      vim.o.cmdheight = 0
      return nil
    end
    return vim.api.nvim_create_autocmd("User", {callback = _12_, once = true, pattern = "DeckHide"})
  else
    return nil
  end
end
return vim.api.nvim_create_autocmd("User", {callback = _11_, pattern = "DeckShow"})
