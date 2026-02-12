-- [nfnl] fnl/plugins/allinone.fnl
local function _1_()
  vim.b.snacks_indent = false
  return nil
end
vim.api.nvim_create_autocmd("FileType", {pattern = {"fennel", "markdown", "harpoon"}, callback = _1_})
local function _2_()
  local mini_file = require("mini.files")
  local mini_icons = require("mini.icons")
  mini_file.setup()
  return mini_icons.setup({extension = {fnl = {glyph = "\238\136\175"}}, filetype = {fennel = {glyph = "\238\136\175"}}})
end
local function _3_()
  return Snacks.picker.grep()
end
local function _4_()
  return Snacks.picker.files()
end
local function _5_()
  return Snacks.picker.files({cwd = vim.fn.stdpath("config")})
end
local function _6_()
  return Snacks.picker.buffers()
end
local function _7_()
  return Snacks.picker.buffers()
end
local function _8_()
  return Snacks.picker.help()
end
local function _9_()
  return Snacks.picker.keymaps()
end
local function _10_()
  return Snacks.picker.lines()
end
local function _11_()
  return Snacks.picker.projects()
end
local function _12_()
  return Snacks.picker.smart()
end
local function _13_()
  return Snacks.picker.undo()
end
local function _14_()
  return Snacks.picker.highlights()
end
local function _15_()
  return Snacks.notifier.show_history()
end
local function _16_()
  return Snacks.terminal()
end
return {{"echasnovski/mini.nvim", config = _2_, keys = {{"<space>e", "<cmd>lua MiniFiles.open()<CR>"}}, lazy = false, version = false}, {"folke/snacks.nvim", keys = {{"<leader>fs", _3_}, {"<leader>ff", _4_}, {"<leader>fc", _5_}, {"<leader>fb", _6_}, {"<leader>bb", _7_}, {"<leader>fh", _8_}, {"<leader>fk", _9_}, {"<leader>fl", _10_}, {"<leader>fp", _11_}, {"<leader>ss", _12_}, {"<leader>su", _13_}, {"<leader>sh", _14_}, {"<leader>nf", _15_}, {"<leader>ot", _16_}}, lazy = false, opts = {indent = {animate = {style = "down"}}, picker = {layout = {preset = "ivy", cycle = false}}, terminal = {}, styles = {}, images = {}, quickfile = {}, notifier = {}}, priority = 1000}}
