-- [nfnl] Compiled from fnl/dotfiles/plugin/indent.fnl by https://github.com/Olical/nfnl, do not edit.
local gs = {char = "\226\148\130", viewport_buffer = 20, use_treesitter = true, show_current_context = true, context_patterns = {"class", "function", "method", "^if", "^while", "^for", "^object", "^table", "block", "arguments", "^attrset$", "^list$", "^let$", "^indented_string$"}, filetype = {"json", "nix"}, filetype_exclude = {"", "help", "fennel", "packer", "lspinfo", "tsplayground", "query", "scheme", "Trouble"}, buftype_exclude = {"terminal", "prompt", "toggleterm"}}
local fennel_gs = {char = "", context_char = "\226\148\130", filetype = {"fennel"}, context_patterns = {"^program$", "^list$", "^sequential_table$", "^table$", "^fn$", "^lambda$", "^hashfn$", "^match$", "^let$", "^each$", "^collect$", "^icollect$", "^accumulate$", "^for$", "^for_clause$", "^quote$", "^iter_bindings$", "^parameters$"}}
local function normal_mode_21()
  for k, v in pairs(gs) do
    vim.g[("indent_blankline_" .. k)] = v
  end
  return nil
end
local function fennel_mode_21()
  for k, v in pairs(fennel_gs) do
    vim.g[("indent_blankline_" .. k)] = v
  end
  return nil
end
local _, indent = pcall(require, "indent_blankline")
return indent.setup({use_treesitter = true, use_treesitter_scope = true, filetype_exclude = {"", "help", "fennel", "packer", "lspinfo", "tsplayground", "query", "scheme", "racket", "qf", "dashboard", "markdown"}, buftype_exclude = {"terminal", "prompt", "toggleterm"}, show_trailing_blankline_indent = false})
