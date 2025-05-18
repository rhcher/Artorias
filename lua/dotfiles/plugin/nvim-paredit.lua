-- [nfnl] fnl/dotfiles/plugin/nvim-paredit.fnl
local paredit = require("nvim-paredit")
local function _1_()
  return paredit.cursor.place_cursor(paredit.wrap.wrap_element_under_cursor("( ", ")"), {placement = "inner_start", mode = "insert"})
end
local function _2_()
  return paredit.cursor.place_cursor(paredit.wrap.wrap_element_under_cursor("(", " )"), {placement = "inner_end", mode = "insert"})
end
local function _3_()
  return paredit.cursor.place_cursor(paredit.wrap.wrap_enclosing_form_under_cursor("( ", ")"), {placement = "inner_start", mode = "insert"})
end
local function _4_()
  return paredit.cursor.place_cursor(paredit.wrap.wrap_enclosing_form_under_cursor("(", " )"), {placement = "inner_end", mode = "insert"})
end
return paredit.setup({keys = {["<localleader>w"] = {_1_, "Wrap element insert head"}, ["<localleader>W"] = {_2_, "Wrap element insert tail"}, ["<localleader>i"] = {_3_, "Wrap form insert head"}, ["<localleader>I"] = {_4_, "Wrap form insert tail"}}})
