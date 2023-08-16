-- [nfnl] Compiled from fnl/dotfiles/plugin.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local lazy = autoload("lazy")
local a = autoload("nfnl.core")
local util = autoload("dotfiles.util")
local lazy_config = {dev = {path = "~/workspace/nvim_plugins/"}, performance = {rtp = {disabled_plugins = {"netrwPlugin", "tarPlugin", "tutor", "zipPlugin", "tohtml", "gzip", "matchit", "matchparen"}}}}
local function use(...)
  local pkgs = {...}
  local plugins = {}
  for i = 1, a.count(pkgs), 2 do
    local name = pkgs[i]
    local opts = pkgs[(i + 1)]
    if (a.get(opts, "mod", nil) ~= nil) then
      local tbl_14_auto = {}
      for k, v in pairs(opts) do
        local k_15_auto, v_16_auto = nil, nil
        if (k == "mod") then
          local function _2_()
            return require(("dotfiles.plugin." .. v))
          end
          k_15_auto, v_16_auto = "config", _2_
        else
          k_15_auto, v_16_auto = k, v
        end
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts = tbl_14_auto
    else
    end
    if (a.get(opts, "dir", nil) ~= nil) then
      table.insert(plugins, opts)
    else
      table.insert(plugins, a.assoc(opts, 1, name))
    end
  end
  return lazy.setup(plugins, lazy_config)
end
local function _7_()
  return (require("notify")).dismiss({silent = true, pending = true})
end
local function _8_()
  return math.floor((vim.o.lines * 0.75))
end
local function _9_()
  return math.floor((vim.o.columns * 0.75))
end
local function _10_()
  return (require("noice")).redirect(vim.fn.getcmdline())
end
local function _11_()
  return vim.cmd.colorscheme("srcery")
end
local function _12_()
  return vim.cmd.colorscheme("paper")
end
local function _13_()
  return vim.cmd.colorscheme("kanagawa")
end
local function _14_(plugin)
  return (vim.opt.rtp):append((plugin.dir .. "/target/release"))
end
local function _15_()
  local function _16_()
    return (require("parinfer")).setup()
  end
  return vim.api.nvim_create_autocmd("VimEnter", {callback = _16_})
end
local function _17_()
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set({"x", "o"}, "aa", "<Plug>SidewaysArgumentTextobjA", opts_1_auto)
  end
  local opts_1_auto
  do
    local tbl_14_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_15_auto, v_16_auto = k_2_auto, v_3_auto
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    opts_1_auto = tbl_14_auto
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  return vim.keymap.set({"x", "o"}, "ia", "<Plug>SidewaysArgumentTextobjI", opts_1_auto)
end
local function _24_()
  local snippy = require("snippy")
  local function _25_()
    if snippy.can_jump(1) then
      return "<Plug>(snippy-next)"
    else
      return "<ESC>A"
    end
  end
  vim.keymap.set({"i", "s"}, "<C-l>", _25_, {expr = true})
  local function _27_()
    if snippy.can_jump(-1) then
      return "<Plug>(snippy-previous)"
    else
      return "<ESC>I"
    end
  end
  return vim.keymap.set({"i", "s"}, "<C-h>", _27_, {expr = true})
end
local function _29_()
  local fzf = require("fzf-lua")
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>ff", fzf.files, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _36_()
      return fzf.files({cwd = "~/.config/nvim"})
    end
    vim.keymap.set("n", "<leader>fp", _36_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>fs", fzf.live_grep_native, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>fb", fzf.buffers, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>bb", fzf.buffers, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>fh", fzf.help_tags, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>fk", fzf.keymaps, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>fl", fzf.blines, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>pl", fzf.lines, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>fo", fzf.oldfiles, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>fc", fzf.commands, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>fq", fzf.quickfix, opts_1_auto)
  end
  local opts_1_auto
  do
    local tbl_14_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_15_auto, v_16_auto = k_2_auto, v_3_auto
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    opts_1_auto = tbl_14_auto
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  return vim.keymap.set("n", "<leader>fg", fzf.git_bcommits, opts_1_auto)
end
local function _70_()
  vim.g.sexp_filetypes = "clojure,scheme,lisp,timl,fennel,janet,racket"
  vim.g.sexp_enable_insert_mode_mappings = 0
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set({"n", "x"}, "<localleader>i", "<Plug>(sexp_round_head_wrap_list)", opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set({"n", "x"}, "<localleader>o", "<Plug>(sexp_raise_list)", opts_1_auto)
  end
  local opts_1_auto
  do
    local tbl_14_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_15_auto, v_16_auto = k_2_auto, v_3_auto
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    opts_1_auto = tbl_14_auto
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  return vim.keymap.set({"n", "x"}, "<localleader>o", "<Plug>(sexp_raise_element))", opts_1_auto)
end
local function _80_()
  local builtin = require("statuscol.builtin")
  local statuscol = require("statuscol")
  return statuscol.setup({relculright = true, segments = {{text = {"%s"}, click = "v:lua.ScSa"}, {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"}, {text = {builtin.foldfunc}, click = "v:lua.ScFa"}}})
end
local function _81_()
  local ufo = require("ufo")
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "zR", ufo.openAllFolds, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "zM", ufo.closeAllFolds, opts_1_auto)
  end
  local ftmap = {vim = "indent", fennel = "treesitter", python = "indent", git = ""}
  local function _88_(bufnr, filetype, buftype)
    return ftmap[filetype]
  end
  return ufo.setup({provider_selector = _88_})
end
local function _89_()
  return require("dotfiles.qftf")
end
local function _90_()
  local illuminate = require("illuminate")
  return illuminate.configure({providers = {"lsp", "regex"}, modes_denylist = {"i"}, large_file_cutoff = 5000, large_file_overrides = {providers = {"lsp"}}})
end
local function _91_()
  return (require("colorizer")).setup()
end
local function _92_()
  local surround = require("nvim-surround")
  local config = require("nvim-surround.config")
  local function _93_()
    return config.get_selection({motion = "a("})
  end
  local function _94_()
    return config.get_selection({motion = "a)"})
  end
  return surround.setup({surrounds = {["("] = {add = {"(", ")"}, find = _93_, delete = "^(.)().-(.)()$"}, [")"] = {add = {"( ", " )"}, find = _94_, delete = "^(. ?)().-( ?.)()$"}}, move_cursor = false})
end
local function _95_(_, opts)
  local leap = require("leap")
  for k, v in pairs(opts) do
    leap.opts[k] = v
  end
  return leap.add_default_mappings()
end
local function _96_()
  return (require("nrpattern")).setup()
end
local function _97_()
  local close_buffers = require("close_buffers")
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _101_()
      return close_buffers.delete({type = "this"})
    end
    vim.keymap.set("n", "<leader>bk", _101_, opts_1_auto)
  end
  local opts_1_auto
  do
    local tbl_14_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_15_auto, v_16_auto = k_2_auto, v_3_auto
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    opts_1_auto = tbl_14_auto
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _105_()
    return close_buffers.delete({type = "hidden"})
  end
  return vim.keymap.set("n", "<leader>bo", _105_, opts_1_auto)
end
local function _106_()
  local ssr = require("ssr")
  local opts_1_auto
  do
    local tbl_14_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_15_auto, v_16_auto = k_2_auto, v_3_auto
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    opts_1_auto = tbl_14_auto
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  return vim.keymap.set({"n", "x"}, "<leader>sr", ssr.open, opts_1_auto)
end
local function _110_()
  vim.g.table_mode_corner = "|"
  return nil
end
return use("folke/lazy.nvim", {event = "VeryLazy"}, "vim-lsp-cxx-highlight", {dir = "/home/rhcher/workspace/vim-lsp-cxx-highlight/", ft = {"c", "cpp"}}, "Olical/nfnl", {ft = "fennel"}, "Olical/conjure", {branch = "develop", mod = "conjure"}, "nvimdev/whiskyline.nvim", {event = "VimEnter", opts = {bg = "#2a2a47"}, dependencies = {"nvim-tree/nvim-web-devicons"}}, "junegunn/fzf", {event = "VeryLazy", build = "./install --bin"}, "karb94/neoscroll.nvim", {event = "VeryLazy", config = true}, "gbprod/substitute.nvim", {config = true, keys = {{"<leader>x", "<cmd>lua require('substitute.exchange').operator()<cr>"}, {"<leader>xx", "<cmd>lua require('substitute.exchange').line()<cr>"}, {"X", "<cmd>lua require('substitute.exchange').visual()<cr>", mode = "x"}, {"<leader>xc", "<cmd>lua require('substitute.exchange').cancel()<cr>"}}}, "rcarriga/nvim-notify", {keys = {{"<leader>un", _7_}}, opts = {timeout = 3000, background_colour = "#000000", max_height = _8_, max_width = _9_}, cond = false}, "folke/noice.nvim", {event = "VeryLazy", dependencies = {"MunifTanjim/nui.nvim"}, keys = {{"<S-Enter>", _10_, mode = "c"}}, opts = {lsp = {progress = {enabled = false}, hover = {enabled = false}, override = {["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["vim.lsp.util.stylize_markdown"] = true, ["cmp.entry.get_documentation"] = true}}, presets = {bottom_search = true, command_palette = true, long_message_to_split = true}, messages = {enabled = false}}}, "nvim-treesitter/nvim-treesitter", {event = "VeryLazy", build = ":TSUpdate", dependencies = {"abecodes/tabout.nvim", "lukas-reineke/indent-blankline.nvim"}, mod = "treesitter", version = false}, "rhcher/srcery.nvim", {config = _11_, cond = true, priority = 1000}, "rhcher/vim-paper", {config = _12_, priority = 1000, cond = false}, "rebelot/kanagawa.nvim", {config = _13_, priority = 1000, cond = false}, "eraserhd/parinfer-rust", {ft = util["lisp-language"], config = _14_, build = "cargo build --release"}, "harrygallagher4/nvim-parinfer-rust", {ft = util["lisp-language"], config = _15_}, "hrsh7th/nvim-cmp", {event = "VeryLazy", dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "PaterJason/cmp-conjure", "hrsh7th/cmp-cmdline", "onsails/lspkind-nvim"}, mod = "cmp", version = false}, "AndrewRadev/sideways.vim", {event = "VeryLazy", init = _17_}, "dcampos/nvim-snippy", {event = "VeryLazy", init = _24_}, "altermo/ultimate-autopair.nvim", {event = {"InsertEnter", "CmdlineEnter"}, mod = "auto-pairs"}, "stevearc/oil.nvim", {cmd = "Oil", dependencies = {"nvim-tree/nvim-web-devicons"}, opts = {columns = {"icon", "permissions", "size", "mtime"}}}, "utilyre/sentiment.nvim", {version = "*", event = "VeryLazy", opts = {}}, "ibhagwan/fzf-lua", {cmd = "FzfLua", dependencies = {"nvim-tree/nvim-web-devicons"}, opts = {winopts = {split = "bot new", border = "single"}, copen = "bot new"}, init = _29_}, "nvim-tree/nvim-web-devicons", {lazy = true, mod = "devicons"}, "tpope/vim-fugitive", {cmd = "Git"}, "guns/vim-sexp", {ft = util["lisp-language"], dependencies = {"tpope/vim-sexp-mappings-for-regular-people"}, init = _70_}, "svban/YankAssassin.vim", {event = "VeryLazy"}, "kana/vim-textobj-user", {event = "VeryLazy", dependencies = {"glts/vim-textobj-comment", "Julian/vim-textobj-variable-segment"}}, "AndrewRadev/linediff.vim", {cmd = "Linediff"}, "tyru/open-browser.vim", {keys = "<Plug>(openbrowser-smart-search)"}, "kevinhwang91/nvim-ufo", {dependencies = {"kevinhwang91/promise-async", {"luukvbaal/statuscol.nvim", config = _80_}}, event = "VeryLazy", config = _81_}, "kevinhwang91/nvim-bqf", {ft = "qf", dev = true, init = _89_, mod = "bqf"}, "RRethy/vim-illuminate", {event = {"BufReadPost", "BufNewFile"}, config = _90_}, "neovim/nvim-lspconfig", {dependencies = {"hrsh7th/cmp-nvim-lsp"}, mod = "lspconfig"}, "nvimdev/lspsaga.nvim", {dependencies = {"nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter"}, event = "LspAttach", mod = "lspsaga"}, "abecodes/tabout.nvim", {event = "VeryLazy", dev = true, opts = {}}, "lukas-reineke/indent-blankline.nvim", {event = "VeryLazy", mod = "indent"}, "numToStr/Comment.nvim", {event = "VeryLazy", config = true}, "mbbill/undotree", {cmd = "UndotreeShow"}, "NvChad/nvim-colorizer.lua", {cmd = "ColorizerToggle", config = _91_}, "tpope/vim-repeat", {event = "VeryLazy"}, "kylechui/nvim-surround", {config = _92_}, "mhinz/vim-grepper", {keys = {"gs"}, mod = "grepper"}, "lewis6991/gitsigns.nvim", {event = {"BufReadPre", "BufNewFile"}, mod = "gitsigns"}, "akinsho/nvim-toggleterm.lua", {mod = "terminal"}, "ggandor/leap.nvim", {event = "VeryLazy", keys = {{"s", mode = {"n", "x", "o"}, desc = "Leap forward to"}, {"S", mode = {"n", "x", "o"}, desc = "Leap backward to"}}, config = _95_}, "booperlv/nvim-gomove", {event = "VeryLazy", mod = "move"}, "zegervdv/nrpattern.nvim", {keys = {"<C-a>", "<C-x>"}, config = _96_}, "ThePrimeagen/harpoon", {keys = {"<leader>uu", "<leader>ua", "<leader>un", "<leader>up", "<leader>tc"}, dependencies = {"nvim-lua/plenary.nvim"}, mod = "harpoon"}, "danymat/neogen", {cmd = "Neogen", opts = {snippet_engine = "snippy"}}, "kazhala/close-buffers.nvim", {keys = {"<leader>bk", "<leader>bo"}, config = _97_}, "anuvyklack/hydra.nvim", {event = "VeryLazy", dependencies = {"anuvyklack/keymap-layer.nvim", "mrjones2014/smart-splits.nvim"}, mod = "hydra"}, "cshuaimin/ssr.nvim", {keys = {"<leader>sr"}, config = _106_}, "dhruvasagar/vim-table-mode", {cmd = "TableModeToggle", init = _110_}, "nvimdev/dashboard-nvim", {event = "VimEnter", mod = "dashboard"})
