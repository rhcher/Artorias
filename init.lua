-- [nfnl] init.fnl
vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.lsp.log.set_level(vim.log.levels.OFF)
local function ensure(user, repo)
  local lazypath = (vim.fn.stdpath("data") .. "/lazy/" .. repo)
  local lazyrepo = string.format("https://github.com/%s/%s", user, repo)
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--single-branch", lazyrepo, lazypath})
    if (vim.v.shell_error ~= 0) then
      vim.api.nvim_echo({{"Failed to clone lazy.nvim:\n", "ErrorMsg"}, {out, "WarningMsg"}, {"\nPress any key to exit..."}}, true, {})
      vim.fn.getchar()
      os.exit(1)
    else
    end
  else
  end
  return vim.opt.rtp:prepend(lazypath)
end
ensure("folke", "lazy.nvim")
ensure("Olical", "nfnl")
require("lazy").setup({change_detection = {notify = false}, spec = {{import = "plugins"}}})
require("config.mappings")
require("config.options")
require("config.diagnostics")
require("config.lsp")
require("config.code_action")
return require("config.fennel_indent")
