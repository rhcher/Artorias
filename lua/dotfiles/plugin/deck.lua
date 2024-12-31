-- [nfnl] Compiled from fnl/dotfiles/plugin/deck.fnl by https://github.com/Olical/nfnl, do not edit.
local deck = require("deck")
require("deck.easy").setup()
local function _1_(e)
  local ctx = e.data.ctx
  ctx.keymap("n", "<Tab>", deck.make_mapping_function("choose_action"))
  ctx.keymap("n", "<C-l>", deck.make_mapping_function("refresh"))
  ctx.keymap("n", "i", deck.make_mapping_function("prompt"))
  ctx.keymap("n", "@", deck.make_mapping_function("toggle_select"))
  ctx.keymap("n", "*", deck.make_mapping_function("toggle_select_all"))
  ctx.keymap("n", "p", deck.make_mapping_function("toggle_preview_mode"))
  ctx.keymap("n", "d", deck.make_mapping_function("delete"))
  ctx.keymap("n", "<CR>", deck.make_mapping_function("default"))
  ctx.keymap("n", "o", deck.make_mapping_function("open"))
  ctx.keymap("n", "O", deck.make_mapping_function("open_keep"))
  ctx.keymap("n", "s", deck.make_mapping_function("open_s"))
  ctx.keymap("n", "v", deck.make_mapping_function("open_v"))
  ctx.keymap("n", "N", deck.make_mapping_function("create"))
  ctx.keymap("n", "<C-u>", deck.make_mapping_function("scroll_preview_up"))
  return ctx.keymap("n", "<C-d>", deck.make_mapping_function("scroll_preview_down"))
end
vim.api.nvim_create_autocmd("User", {callback = _1_, pattern = "DeckStart"})
vim.keymap.set("n", "<Leader>ff", "<Cmd>Deck files<CR>", {desc = "Show recent files, buffers, and more"})
vim.keymap.set("n", "<Leader>gr", "<Cmd>Deck grep<CR>", {desc = "Start grep search"})
vim.keymap.set("n", "<Leader>gi", "<Cmd>Deck git<CR>", {desc = "Open git launcher"})
vim.keymap.set("n", "<Leader>he", "<Cmd>Deck helpgrep<CR>", {desc = "Live grep all help tags"})
local function _2_()
  local ctx = require("deck").get_history()[1]
  if ctx then
    return ctx.show()
  else
    return nil
  end
end
return vim.keymap.set("n", "<Leader>;", _2_)
