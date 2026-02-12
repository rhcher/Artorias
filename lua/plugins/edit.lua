-- [nfnl] fnl/plugins/edit.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local g = autoload("config.global")
local function _2_()
  return require("better_escape").setup({mappings = {i = {j = {k = "<Esc>"}}}, default_mappings = false})
end
local function _3_(plugin)
  return vim.opt.rtp:append((plugin.dir .. "/target/release"))
end
local function _4_()
  local function _5_()
    return require("parinfer").setup()
  end
  return vim.api.nvim_create_autocmd("VimEnter", {callback = _5_})
end
local function _6_()
  vim.g["conjure#filetype#rust"] = false
  vim.g["conjure#mapping#doc_word"] = {"gk"}
  return nil
end
local function _7_()
  local _, blink = pcall(require, "blink.cmp")
  local _0, snippy = pcall(require, "snippy")
  local function _8_(snippet)
    return snippy.expand_snippet(snippet)
  end
  local function _9_(filter)
    if (filter == nil) then
      return nil
    elseif (filter ~= nil) then
      return snippy.can_jump(filter.direction)
    else
      return nil
    end
  end
  local function _11_(direction)
    if (direction == 1) then
      return snippy.next()
    elseif (direction == -1) then
      return snippy.previous()
    else
      return nil
    end
  end
  return blink.setup({keymap = {preset = "super-tab", ["<Tab>"] = {"select_and_accept", "snippet_forward", "fallback"}, ["<C-k>"] = false}, snippets = {expand = _8_, active = _9_, jump = _11_}, cmdline = {keymap = {preset = "inherit"}, completion = {menu = {auto_show = true}}}, appearance = {use_nvim_cmp_as_default = true, nerd_font_variant = "mono"}, completion = {trigger = {prefetch_on_insert = true}, list = {selection = {preselect = false}}, accept = {dot_repeat = false}}, sources = {default = {"lsp", "path", "buffer"}}, signature = {enabled = true}})
end
local function _13_()
  local snippy = require("snippy")
  do
    local opts_3_auto
    do
      local tbl_21_ = {}
      for k_4_auto, v_5_auto in pairs(({expr = true} or {})) do
        local k_22_, v_23_ = k_4_auto, v_5_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_3_auto = tbl_21_
    end
    if (opts_3_auto.noremap == nil) then
      opts_3_auto.noremap = true
    else
    end
    if (opts_3_auto.silent == nil) then
      opts_3_auto.silent = true
    else
    end
    local function _17_()
      if snippy.can_jump(1) then
        return "<Plug>(snippy-next)"
      else
        return "<ESC>A"
      end
    end
    vim.keymap.set({"i", "s"}, "<C-l>", _17_, opts_3_auto)
  end
  local opts_3_auto
  do
    local tbl_21_ = {}
    for k_4_auto, v_5_auto in pairs(({expr = true} or {})) do
      local k_22_, v_23_ = k_4_auto, v_5_auto
      if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
        tbl_21_[k_22_] = v_23_
      else
      end
    end
    opts_3_auto = tbl_21_
  end
  if (opts_3_auto.noremap == nil) then
    opts_3_auto.noremap = true
  else
  end
  if (opts_3_auto.silent == nil) then
    opts_3_auto.silent = true
  else
  end
  local function _22_()
    if snippy.can_jump(-1) then
      return "<Plug>(snippy-previous)"
    else
      return "<ESC>I"
    end
  end
  return vim.keymap.set({"i", "s"}, "<C-h>", _22_, opts_3_auto)
end
local function _24_()
  local pair = require("ultimate-autopair")
  return pair.setup({cr = {conf = {nft = g["lisp-language"]}}, bs = {single_delete = false, space = false}, space = {enable = true}, tabout = {enable = true, map = "<tab>", hopout = true, do_nothing_if_fail = false}})
end
local function _25_()
  local paredit = require("nvim-paredit")
  local function _26_()
    return paredit.cursor.place_cursor(paredit.wrap.wrap_element_under_cursor("( ", ")"), {placement = "inner_start", mode = "insert"})
  end
  local function _27_()
    return paredit.cursor.place_cursor(paredit.wrap.wrap_element_under_cursor("(", " )"), {placement = "inner_end", mode = "insert"})
  end
  local function _28_()
    return paredit.cursor.place_cursor(paredit.wrap.wrap_enclosing_form_under_cursor("( ", ")"), {placement = "inner_start", mode = "insert"})
  end
  local function _29_()
    return paredit.cursor.place_cursor(paredit.wrap.wrap_enclosing_form_under_cursor("(", " )"), {placement = "inner_end", mode = "insert"})
  end
  return paredit.setup({keys = {["<localleader>w"] = {_26_, "Wrap element insert head"}, ["<localleader>W"] = {_27_, "Wrap element insert tail"}, ["<localleader>i"] = {_28_, "Wrap form insert head"}, ["<localleader>I"] = {_29_, "Wrap form insert tail"}}})
end
local function _30_()
  local surround = require("nvim-surround")
  local config = require("nvim-surround.config")
  local function _31_()
    return config.get_selection({motion = "a("})
  end
  local function _32_()
    return config.get_selection({motion = "a)"})
  end
  return surround.setup({surrounds = {["("] = {add = {"(", ")"}, find = _31_, delete = "^(.)().-(.)()$"}, [")"] = {add = {"( ", " )"}, find = _32_, delete = "^(. ?)().-( ?.)()$"}}, move_cursor = false})
end
return {{"max397574/better-escape.nvim", config = _2_, event = "VeryLazy"}, {"eraserhd/parinfer-rust", build = "cargo build --release", config = _3_, ft = g["lisp-language"]}, {"harrygallagher4/nvim-parinfer-rust", config = _4_, ft = g["lisp-language"]}, {"Olical/conjure", branch = "main", init = _6_, lazy = false}, {"saghen/blink.cmp", build = "cargo build --release", config = _7_, event = {"InsertEnter", "CmdlineEnter"}, version = false}, {"dcampos/nvim-snippy", config = _13_}, {"altermo/ultimate-autopair.nvim", branch = "v0.6", config = _24_, dependencies = {"nvim-treesitter/nvim-treesitter"}, lazy = false}, {"svban/YankAssassin.vim", event = "VeryLazy"}, {"kana/vim-textobj-user", dependencies = {"glts/vim-textobj-comment"}, event = "VeryLazy"}, {"julienvincent/nvim-paredit", config = _25_, ft = g["lisp-language"]}, {"svban/YankAssassin.vim", event = "VeryLazy"}, {"kana/vim-textobj-user", dependencies = {"glts/vim-textobj-comment"}, event = "VeryLazy"}, {"chrisgrieser/nvim-various-textobjs", keys = {{"iv", "<cmd>lua require('various-textobjs').subword('inner')<CR>", mode = {"o", "x"}}, {"av", "<cmd>lua require('various-textobjs').subword('outer')<CR>", mode = {"o", "x"}}}}, {"kylechui/nvim-surround", config = _30_, event = "VeryLazy"}, {"tani/dmacro.vim", keys = {{"<C-y>", "<Plug>(dmacro-play-macro)", mode = {"i", "n"}}}, lazy = false}}
