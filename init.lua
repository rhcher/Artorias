-- Entrypoint for my Neovim configuration!
-- We simply bootstrap packer and Aniseed here.
-- It's then up to Aniseed to compile and load fnl/init.fnl
vim.loader.enable()

vim.lsp.set_log_level("ERROR")

if vim.g.nvui then
  -- Configure through vim commands
  vim.cmd [[set guifont=Jetbrains\ Mono:h14]]
  vim.cmd [[NvuiCmdFontFamily JetBrains Mono]]
  vim.cmd [[NvuiCmdFontSize 13.0]]
end

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local package_path = vim.fn.stdpath("data") .. "/lazy"

function ensure(repo, package, dir)
  if not dir then
    local path = package_path .. "/" .. package
    if not vim.loop.fs_stat(path) then
      vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/" .. repo .. ".git",
        path,
      })
    end
    vim.opt.runtimepath:prepend(path)
  else
    local install_path = string.format("%s/%s", package_path, package)
    vim.fn.system(string.format("rm -r %s", install_path))
    vim.fn.system(string.format("ln -s %s %s", repo, package_path))
    vim.opt.runtimepath:prepend(install_path)
  end
end

ensure("folke/lazy.nvim", "lazy.nvim")
ensure("Olical/aniseed", "aniseed")

vim.opt.runtimepath:prepend(lazy_path)

-- Enable Aniseed's automatic compilation and loading of Fennel source code.
vim.g["aniseed#env"] = {
  module = "dotfiles.init",
  compile = true
}

vim.cmd [[let g:loaded_netrwPlugin = 1]]
vim.cmd [[let g:loaded_tarPlugin = 1]]
vim.cmd [[let g:loaded_tutor_mode_plugin = 1]]
vim.cmd [[let g:loaded_zipPlugin = 1]]
vim.cmd [[let g:loaded_gzip = 1]]
vim.cmd [[let g:loaded_2html_plugin = 1]]
vim.cmd [[let g:loaded_matchit=1]]
vim.cmd [[let g:loaded_matchparen=1]]
vim.cmd [[let g:loaded_python_provider = 0]]
vim.cmd [[let g:loaded_python3_provider = 0]]
vim.cmd [[let g:loaded_node_provider = 0]]
vim.cmd [[let g:loaded_perl_provider = 0]]
