-- [nfnl] fnl/dotfiles/plugin/completion.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("dotfiles.util")
local _, blink = pcall(require, "blink.cmp")
local _0, snippy = pcall(require, "snippy")
local function _2_(snippet)
  return snippy.expand_snippet(snippet)
end
local function _3_(filter)
  if (filter == nil) then
    return nil
  elseif (filter ~= nil) then
    return snippy.can_jump(filter.direction)
  else
    return nil
  end
end
local function _5_(direction)
  if (direction == 1) then
    return snippy.next()
  elseif (direction == -1) then
    return snippy.previous()
  else
    return nil
  end
end
return blink.setup({keymap = {preset = "super-tab", ["<Tab>"] = {"select_and_accept", "snippet_forward", "fallback"}}, snippets = {expand = _2_, active = _3_, jump = _5_}, cmdline = {keymap = {preset = "inherit"}, completion = {menu = {auto_show = true}}}, appearance = {use_nvim_cmp_as_default = true, nerd_font_variant = "mono"}, completion = {trigger = {prefetch_on_insert = true}, list = {selection = {preselect = false}}, accept = {dot_repeat = false}}, sources = {default = {"lsp", "path", "buffer"}}, signature = {enabled = true}})
