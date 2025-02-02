-- [nfnl] Compiled from fnl/dotfiles/plugin/terminal.fnl by https://github.com/Olical/nfnl, do not edit.
do
  local _, term = pcall(require, "toggleterm")
  local function _1_(t)
    if (t.direction == "horizontal") then
      return 15
    elseif (t.direction == "vertical") then
      return (vim.o.columns * 0.4)
    else
      return nil
    end
  end
  term.setup({size = _1_, open_mapping = "<M-=>", hide_numbers = true, start_in_insert = true, insert_mappings = true, persist_size = true, direction = "vertical", close_on_exit = true, shell = vim.o.shell, shade_terminals = false})
end
do
  local opts_1_auto
  do
    local tbl_16_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_auto, v_18_auto = k_2_auto, v_3_auto
      if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
        tbl_16_auto[k_17_auto] = v_18_auto
      else
      end
    end
    opts_1_auto = tbl_16_auto
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  vim.keymap.set("n", "<leader>ot", "<cmd>ToggleTerm direction=horizontal<CR>", opts_1_auto)
end
local opts_1_auto
do
  local tbl_16_auto = {}
  for k_2_auto, v_3_auto in pairs((nil or {})) do
    local k_17_auto, v_18_auto = k_2_auto, v_3_auto
    if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
      tbl_16_auto[k_17_auto] = v_18_auto
    else
    end
  end
  opts_1_auto = tbl_16_auto
end
if (opts_1_auto.noremap == nil) then
  opts_1_auto.noremap = true
else
end
if (opts_1_auto.silent == nil) then
  opts_1_auto.silent = true
else
end
return vim.keymap.set("n", "<leader>oT", "<cmd>ToggleTerm direction=vertical<CR>", opts_1_auto)
