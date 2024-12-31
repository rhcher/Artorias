-- [nfnl] Compiled from fnl/dotfiles/plugin/completion.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("dotfiles.util")
local underline
local function _2_(entry1, entry2)
  local _, entry1_under = entry1.completion_item.label:find("^_+")
  local _0, entry2_under = entry2.completion_item.label:find("^_+")
  entry1_under = (entry1_under or 0)
  entry2_under = (entry2_under or 0)
  if (entry1_under > entry2_under) then
    return false
  elseif (entry1_under < entry2_under) then
    return true
  else
    return nil
  end
end
underline = _2_
local cmp_window_opts = {border = "single", winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None"}
local cmp_buffer
local function _4_()
  local bufs = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    bufs[vim.api.nvim_win_get_buf(win)] = true
  end
  return vim.tbl_keys(bufs)
end
cmp_buffer = {name = "buffer", option = {keyword_length = 3, keyword_pattern = "\\k\\+", get_bufnrs = _4_}}
local ok_3f, cmp = pcall(require, "cmp")
local snippy = require("snippy")
local lspkind = require("lspkind")
if ok_3f then
  local function _5_(args)
    return snippy.expand_snippet(args.body)
  end
  local function _6_(fallback)
    if cmp.visible() then
      return cmp.confirm({select = true, behavior = cmp.ConfirmBehavior.Insert})
    elseif snippy.can_expand_or_advance() then
      return snippy.expand_or_advance()
    else
      return fallback()
    end
  end
  local function _8_(entry, vim_item)
    vim_item["dup"] = (({conjure = 0})[entry.source.name] or 0)
    return vim_item
  end
  cmp.setup({snippet = {expand = _5_}, performance = {debounce = 20}, completion = {completeopt = "menu,menuone,noselect", keyword_pattern = "\\k\\+"}, sorting = {comparators = {cmp.config.compare.offset, cmp.config.compare.exact, cmp.config.compare.score, cmp.config.compare.recently_used, cmp.config.compare.locality, cmp.config.compare.length, cmp.config.compare.order}}, window = {documentation = cmp_window_opts, completion = cmp_window_opts}, mapping = cmp.mapping.preset.insert({["<C-d>"] = cmp.mapping.scroll_docs(( - 4)), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<C-space>"] = cmp.mapping.complete(), ["<C-e>"] = cmp.mapping.close(), ["<C-y>"] = cmp.mapping.confirm({select = true, behavior = cmp.ConfirmBehavior.Replace}), ["<Tab>"] = cmp.mapping(_6_, {"s", "i", "c"})}), formatting = {fields = {"kind", "abbr", "menu"}, format = lspkind.cmp_format({mode = "symbol", maxwidth = 50, before = _8_})}, sources = cmp.config.sources({{name = "nvim_lsp"}}, {{name = "path"}, cmp_buffer})})
  cmp.setup.filetype({"fennel", "lisp", "scheme", "clojure", "janet", "timl"}, {sources = {{name = "conjure"}, {name = "path"}, cmp_buffer}})
  cmp.setup.cmdline("/", {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "buffer"}}})
  return cmp.setup.cmdline(":", {mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({{name = "cmdline"}}, {{name = "path"}})})
else
  return nil
end
