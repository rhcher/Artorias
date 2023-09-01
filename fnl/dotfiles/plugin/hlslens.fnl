(import-macros {: map : augroup} "dotfiles.macros")

(local hlslens (require :hlslens))
(hlslens.setup)

(let [start-str "<Cmd>lua require('hlslens').start()<CR>"]
  (map :n :n (.. "<Cmd>execute('normal! ' . v:count1 . 'n')<CR>" start-str))
  (map :n :N (.. "<Cmd>execute('normal! ' . v:count1 . 'N')<CR>" start-str))
  (map [:n :x] :* (.. "<Plug>(asterisk-z*)" start-str))
  (map [:n :x] :# (.. "<Plug>(asterisk-z#)" start-str))
  (map [:n :x] :g* (.. "<Plug>(asterisk-gz*)" start-str))
  (map [:n :x] :g# (.. "<Plug>(asterisk-gz*)" start-str)))

(augroup "VMlens"
         [[:User] {:pattern "visual_multi_start"
                   :callback #(. (require "dotfiles.plugin.vmlens") :start)}]
         [[:User] {:pattern "visual_multi_exit"
                   :callback #(. (require "dotfiles.plugin.vmlens") :exit)}])
