-- [nfnl] fnl/plugins/utils.fnl
vim.g.grepper = {tools = {"rg", "git"}, dir = "repo,file", simple_prompt = 1, searchreg = 1, stop = 50000, rg = {grepprg = "rg -H --no-heading --vimgrep --smart-case", grepformat = "%f:%l:%c:%m,%f:%l:%m"}}
vim.cmd("let g:grepper.repo = ['.git', '.hg', '.svn', 'stack.yaml', 'dune-project', '.ccls-root', 'Cargo.toml', 'compile_commands.json']")
vim.cmd("aug Grepper\nau!\nau User Grepper ++nested call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': '\\%#' . getreg('/')}}}) | bo cope\naug END")
vim.cmd("command! Todo :Grepper -noprompt -tool git -grepprg git grep -nIi '\\(TODO\\|FIXME\\)'")
local function _1_()
  local opts_3_auto
  do
    local tbl_21_ = {}
    for k_4_auto, v_5_auto in pairs((nil or {})) do
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
  return vim.keymap.set("n", "<leader>ou", ":UndotreeShow<cr>:UndotreeFocus<cr>", opts_3_auto)
end
local function _5_()
  local harpoon = require("harpoon")
  harpoon:setup()
  do
    local opts_3_auto
    do
      local tbl_21_ = {}
      for k_4_auto, v_5_auto in pairs((nil or {})) do
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
    local function _9_()
      return harpoon:list():add()
    end
    vim.keymap.set("n", "<leader>ua", _9_, opts_3_auto)
  end
  local opts_3_auto
  do
    local tbl_21_ = {}
    for k_4_auto, v_5_auto in pairs((nil or {})) do
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
  local function _13_()
    return harpoon.ui:toggle_quick_menu(harpoon:list())
  end
  return vim.keymap.set("n", "<leader>uu", _13_, opts_3_auto)
end
local function _14_()
  local close_buffers = require("close_buffers")
  do
    local opts_3_auto
    do
      local tbl_21_ = {}
      for k_4_auto, v_5_auto in pairs((nil or {})) do
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
    local function _18_()
      return close_buffers.delete({type = "this"})
    end
    vim.keymap.set("n", "<leader>bk", _18_, opts_3_auto)
  end
  local opts_3_auto
  do
    local tbl_21_ = {}
    for k_4_auto, v_5_auto in pairs((nil or {})) do
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
    return close_buffers.delete({type = "hidden"})
  end
  return vim.keymap.set("n", "<leader>bo", _22_, opts_3_auto)
end
local function _23_()
  local _, hydra = pcall(require, "hydra")
  hydra({name = "Side scroll", mode = "n", body = "z", heads = {{"h", "5zh"}, {"l", "5zl", {desc = "\226\134\144/\226\134\146"}}, {"H", "zH"}, {"L", "zL", {desc = "half screen \226\134\144/\226\134\146"}}}})
  local _0, splits = pcall(require, "smart-splits")
  return hydra({name = "smooth scroll", mode = "n", body = "<C-w>", heads = {{"<", splits.resize_left}, {">", splits.resize_right}, {"+", splits.resize_up}, {"-", splits.resize_down}}})
end
return {{"mhinz/vim-grepper", keys = {{"gs", "<plug>(GrepperOperator)", mode = {"n", "x", "o"}}}}, {"mbbill/undotree", cmd = "UndotreeShow", config = _1_}, {"ThePrimeagen/harpoon", branch = "harpoon2", config = _5_, dependencies = {"nvim-lua/plenary.nvim"}, keys = {"<leader>uu", "<leader>ua", "<leader>un", "<leader>up", "<leader>tc"}}, {"kazhala/close-buffers.nvim", config = _14_, keys = {"<leader>bk", "<leader>bo"}}, {"anuvyklack/hydra.nvim", config = _23_, dependencies = {"anuvyklack/keymap-layer.nvim", "mrjones2014/smart-splits.nvim"}, event = "VeryLazy"}, {"dhruvasagar/vim-table-mode", cmd = "TableModeToggle"}}
