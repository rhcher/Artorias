(module dotfiles.plugin.grepper
  {autoload {nvim aniseed.nvim}})

(vim.api.nvim_set_keymap
  :n
  :<leader>*
  ":Grepper -tool rg -cword -noprompt<CR>"
  {:noremap true})

(set vim.g.grepper {:tools [:rg :git]
                    :dir "repo,file"
                    :open 0
                    :switch 1
                    :jump 0
                    :simple_prompt 1
                    :quickfix 1
                    :searchreg 1
                    :highlight 0
                    :stop 10000
                    :rg {:grepprg "rg -H --no-heading --vimgrep --smart-case"
                         :grepformat "%f:%l:%c:%m,%f:%l:%m"}})

(vim.cmd "aug Grepper 
            au! 
            au User Grepper ++nested call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': '\\%#' . getreg('/')}}}) | bo cope 
           aug END")

(vim.cmd "command! Todo :Grepper -noprompt -tool git -grepprg git grep -nIi '\\(TODO\\|FIXME\\)'")
;; Todo

(vim.cmd "nmap gs <plug>(GrepperOperator)
          xmap gs <plug>(GrepperOperator)")
