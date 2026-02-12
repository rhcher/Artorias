-- [nfnl] fnl/plugins/treesitter.fnl
local function _1_()
  return vim.treesitter.start()
end
vim.api.nvim_create_autocmd("FileType", {pattern = "fennel", callback = _1_})
local function _2_()
  local ts = require("nvim-treesitter")
  return ts.install({"c", "cpp", "rust", "lua", "python", "cmake", "markdown", "markdown_inline", "vim", "fennel", "query", "ocaml", "ocaml_interface", "haskell", "scheme", "regex", "bash", "luap", "racket", "html"})
end
return {"nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate", config = _2_, lazy = false}
