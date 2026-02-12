-- [nfnl] fnl/dotfiles/plugin/treesitter.fnl
do
  local _, ts = pcall(require, "nvim-treesitter")
  ts.setup({install_dir = (vim.fn.stdpath("data") .. "/site")})
  ts.install({"cpp", "rust", "python", "cmake", "markdown", "markdown_inline", "vim", "fennel", "query", "ocaml", "ocaml_interface", "haskell", "scheme", "regex", "bash", "luap", "racket", "html", "zig"})
end
local function _1_()
  return vim.treesitter.start()
end
return vim.api.nvim_create_autocmd("FileType", {pattern = {"fennel", "zig"}, callback = _1_})
