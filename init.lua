-- Entrypoint for my Neovim configuration!
-- We simply bootstrap packer and Aniseed here.
-- It's then up to Aniseed to compile and load fnl/init.fnl

local execute = vim.api.nvim_command
local fn = vim.fn

if vim.g.nvui then
  -- Configure through vim commands
  vim.cmd [[set guifont=Jetbrains\ Mono:h14]]
  vim.cmd [[NvuiCmdFontFamily JetBrains Mono]]
  vim.cmd [[NvuiCmdFontSize 13.0]]
end

local pack_path = fn.stdpath("data") .. "/site/pack"
local fmt = string.format

local function ensure (user, repo)
  -- Ensures a given github.com/USER/REPO is cloned in the pack/packer/start directory.
  local install_path = fmt("%s/packer/start/%s", pack_path, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    execute(fmt("packadd %s", repo))
  end
end

-- Bootstrap essential plugins required for installing and loading the rest.
ensure("wbthomason", "packer.nvim")
ensure("Olical", "aniseed")
ensure("lewis6991", "impatient.nvim")

-- Load impatient which pre-compiles and caches Lua modules.
require("impatient")

-- Enable Aniseed's automatic compilation and loading of Fennel source code.
vim.g["aniseed#env"] = {
  module = "dotfiles.init",
  compile = true
}

vim.cmd [[
augroup matchup_matchparen_highlight
  autocmd!
  autocmd ColorScheme * hi! MatchWord ctermfg=none ctermbg=none guifg=none guibg=none
augroup END]]

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
vim.cmd [[let g:do_filetype_lua = 1]]
vim.cmd [[let g:did_load_filetypes = 0]]
