(module dotfiles.plugin.grepper)

(vim.keymap.set
  :n
  :<leader>*
  ":Grepper -tool rg -cword -noprompt<CR>"
  {:noremap true})

(set vim.g.grepper {:tools [:rg :git]
                    :dir "repo,file"
                    :simple_prompt 1
                    :searchreg 1
                    :stop 50000
                    :rg {:grepprg "rg -H --no-heading --vimgrep --smart-case"
                         :grepformat "%f:%l:%c:%m,%f:%l:%m"}})

(vim.cmd "let g:grepper.repo = ['.git', '.hg', '.svn', 'Makefile', 'stack.yaml', 'dune-project', '.ccls-root', 'Cargo.toml']")

(vim.cmd "aug Grepper 
            au! 
            au User Grepper ++nested call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': '\\%#' . getreg('/')}}}) | bo cope 
          aug END")

(vim.cmd "command! Todo :Grepper -noprompt -tool git -grepprg git grep -nIi '\\(TODO\\|FIXME\\)'")
;; Todo

(vim.cmd "nmap gs <plug>(GrepperOperator)
          xmap gs <plug>(GrepperOperator)")
