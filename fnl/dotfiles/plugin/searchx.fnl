(module dotfiles.plugin.searchx)

(defn- map [mode from to]
  (let [to (.. "<cmd>" to "<CR>")]
    (vim.keymap.set mode from to {:noremap true :silent true})))

(map [:n :x] "?" "call searchx#start({ 'dir': 0 })")
(map [:n :x] "/" "call searchx#start({ 'dir': 1 })")
(map :c ";" "call searchx#select()")

(map [:n :x :c] "<C-k>" "call searchx#prev()")
(map [:n :x :c] "<C-j>" "call searchx#next()")

(map :n "<C-l>" "call searchx#clear()")

(vim.cmd "let g:searchx = {}")
(vim.cmd "function g:searchx.convert(input) abort
            if a:input !~# '\\k'
              return '\\V' .. a:input
            endif
            return a:input[0] .. substitute(a:input[1:], '\\\\\\@<! ', '.\\\\{-}', 'g')
          endfunction")
