-- [nfnl] fnl/dotfiles/plugin/dap.fnl
local find_next_start
local function _1_(str, cur_idx)
  while ((cur_idx <= #str) and (str:sub(cur_idx, cur_idx) == " ")) do
    cur_idx = (cur_idx + 1)
  end
  return cur_idx
end
find_next_start = _1_
local str2argtable
local function _2_(str)
  str = string.gsub(str, "^%s*(.-)%s*$", "%1")
  local arg_list = {}
  local start = 1
  local i = 1
  local quote_refs_cnt = 0
  while (i <= #str) do
    local c = str:sub(i, i)
    if (c == "\"") then
      quote_refs_cnt = (quote_refs_cnt + 1)
      start = i
      i = (i + 1)
      while ((i <= #str) and (str:sub(i, i) ~= "\"")) do
        i = (i + 1)
      end
      if (i <= #str) then
        quote_refs_cnt = (quote_refs_cnt - 1)
        arg_list[(#arg_list + 1)] = str:sub(start, i)
        start = find_next_start(str, (i + 1))
        i = start
      else
      end
    elseif (c == " ") then
      arg_list[(#arg_list + 1)] = str:sub(start, (i - 1))
      start = find_next_start(str, (i + 1))
      i = start
    else
      i = (i + 1)
    end
  end
  if ((start ~= i) and (quote_refs_cnt == 0)) then
    arg_list[(#arg_list + 1)] = str:sub(start, i)
  else
  end
  return arg_list
end
str2argtable = _2_
do
  local dap = require("dap")
  local dapui = require("dapui")
  dap.adapters.cppdbg = {id = "cppdbg", type = "executable", command = "/home/rhcher/sources/dap/cpptools/extension/debugAdapters/bin/OpenDebugAD7"}
  local function _6_()
    return vim.fn.input("Path to executable: ", (vim.fn.getcwd() .. "/"), "file")
  end
  local function _7_()
    return str2argtable(vim.fn.input("Input: "))
  end
  local function _8_()
    return vim.fn.input("Path to executable", (vim.fn.getcwd() .. "/"), "file")
  end
  dap.configurations.cpp = {{name = "Launch file", type = "cppdbg", request = "launch", program = _6_, args = _7_, cwd = "${workspaceFolder}", stopAtEntry = true, setupCommands = {{text = "-enable-pretty-printing", description = "enable pretty printing", ignoreFailures = false}}}, {name = "Attach process", type = "cppdbg", request = "attach", processId = require("dap.utils").pick_process, cwd = "${workspaceFolder}", program = _8_}}
  dap.configurations.c = dap.configurations.cpp
  dapui.setup({})
  local function _9_()
    return dapui.open({})
  end
  dap.listeners.after.event_initialized["dapui_config"] = _9_
  local function _10_()
    return dapui.close({})
  end
  dap.listeners.before.event_terminated["dapui_config"] = _10_
  local function _11_()
    return dapui.close({})
  end
  dap.listeners.before.event_exited["dapui_config"] = _11_
end
local dap_breakpoint = {error = {linehl = "", numhl = "", text = "\240\159\155\145", texthl = "LspDiagnosticsSignError"}, rejected = {linehl = "", numhl = "", text = "\239\151\163", texthl = "LspDiagnosticsSignHint"}, stopped = {linehl = "DiagnosticUnderlineInfo", numhl = "LspDiagnosticsSignInformation", text = "\226\173\144\239\184\143", texthl = "LspDiagnosticsSignInformation"}}
vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
do
  local opts_1_auto
  do
    local tbl_16_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_, v_18_ = k_2_auto, v_3_auto
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts_1_auto = tbl_16_
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _15_()
    return require("dap").continue()
  end
  vim.keymap.set({"n"}, "<F5>", _15_, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_16_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_, v_18_ = k_2_auto, v_3_auto
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts_1_auto = tbl_16_
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _19_()
    return require("dap").step_over()
  end
  vim.keymap.set({"n"}, "<F10>", _19_, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_16_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_, v_18_ = k_2_auto, v_3_auto
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts_1_auto = tbl_16_
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _23_()
    return require("dap").step_into()
  end
  vim.keymap.set({"n"}, "<F11>", _23_, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_16_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_, v_18_ = k_2_auto, v_3_auto
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts_1_auto = tbl_16_
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _27_()
    return require("dap").step_out()
  end
  vim.keymap.set({"n"}, "<F12>", _27_, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_16_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_, v_18_ = k_2_auto, v_3_auto
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts_1_auto = tbl_16_
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _31_()
    return require("dap").toggle_breakpoint()
  end
  vim.keymap.set({"n"}, "<leader>db", _31_, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_16_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_, v_18_ = k_2_auto, v_3_auto
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts_1_auto = tbl_16_
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _35_()
    return require("dap").set_breakpoint()
  end
  vim.keymap.set({"n"}, "<leader>dB", _35_, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_16_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_, v_18_ = k_2_auto, v_3_auto
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts_1_auto = tbl_16_
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _39_()
    return require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
  end
  vim.keymap.set({"n"}, "<leader>lp", _39_, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_16_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_, v_18_ = k_2_auto, v_3_auto
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts_1_auto = tbl_16_
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _43_()
    return require("dap").repl.open()
  end
  vim.keymap.set({"n"}, "<leader>dr", _43_, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_16_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_, v_18_ = k_2_auto, v_3_auto
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts_1_auto = tbl_16_
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _47_()
    return require("dap").run_last()
  end
  vim.keymap.set({"n"}, "<leader>dl", _47_, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_16_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_, v_18_ = k_2_auto, v_3_auto
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts_1_auto = tbl_16_
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _51_()
    return require("dap").terminate()
  end
  vim.keymap.set({"n"}, "<leader>dt", _51_, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_16_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_, v_18_ = k_2_auto, v_3_auto
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts_1_auto = tbl_16_
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _55_()
    return require("dap.ui.widgets").hover()
  end
  vim.keymap.set({"n", "v"}, "<leader>dh", _55_, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_16_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_, v_18_ = k_2_auto, v_3_auto
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts_1_auto = tbl_16_
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _59_()
    return require("dap.ui.widgets").preview()
  end
  vim.keymap.set({"n", "v"}, "<leader>dp", _59_, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_16_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_, v_18_ = k_2_auto, v_3_auto
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts_1_auto = tbl_16_
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _63_()
    local widgets = require("dap.ui.widgets")
    return widgets.centered_float(widgets.frames)
  end
  vim.keymap.set({"n"}, "<leader>df", _63_, opts_1_auto)
end
local opts_1_auto
do
  local tbl_16_ = {}
  for k_2_auto, v_3_auto in pairs((nil or {})) do
    local k_17_, v_18_ = k_2_auto, v_3_auto
    if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
      tbl_16_[k_17_] = v_18_
    else
    end
  end
  opts_1_auto = tbl_16_
end
if (opts_1_auto.noremap == nil) then
  opts_1_auto.noremap = true
else
end
if (opts_1_auto.silent == nil) then
  opts_1_auto.silent = true
else
end
local function _67_()
  local widgets = require("dap.ui.widgets")
  return widgets.centered_float(widgets.scopes)
end
return vim.keymap.set({"n"}, "<leader>ds", _67_, opts_1_auto)
