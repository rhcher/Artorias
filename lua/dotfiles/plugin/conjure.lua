-- [nfnl] Compiled from fnl/dotfiles/plugin/conjure.fnl by https://github.com/Olical/nfnl, do not edit.
vim.g["conjure#filetype#rust"] = false
vim.g["conjure#mapping#doc_word"] = {"gk"}
local group = vim.api.nvim_create_augroup("conjure-log-no-diag", {clear = true})
vim.api.nvim_create_autocmd({"BufNewFile"}, {pattern = {"conjure-log-*"}, command = "lua vim.diagnostic.disable(0)", group = group})
return nil
