(module dotfiles.plugin.bqf
  {autoload {nvim aniseed.nvim
             bqf bqf}})

(bqf.setup {:preview {:auto_preview false}})
(vim.cmd "au FileType qf nnoremap <buffer><silent> q :ccl<CR>")
