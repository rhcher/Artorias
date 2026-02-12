(local {: autoload} (require :nfnl.module))
(local util (autoload :dotfiles.util))

; (let [ix (require "ix")
;       snippy (require "snippy")]
;   (ix.setup {:expand_snippet (fn [snippet_body]
;                                (snippy.expand_snippet snippet_body))})
;   (vim.keymap.set [:i :c] :<C-d> (ix.action.scroll (+ 0 3)))
;   (vim.keymap.set [:i :c] :<C-u> (ix.action.scroll (- 0 3)))
;   (vim.keymap.set [:i :c] :<C-Space> (ix.action.completion.complete))
;   (vim.keymap.set [:i :c] :<C-n> (ix.action.completion.select_next))
;   (vim.keymap.set [:i :c] :<C-p> (ix.action.completion.select_prev))
;   (vim.keymap.set [:i :c] :<C-e> (ix.action.completion.close))
;   (ix.charmap.set :c :<Tab> (ix.action.completion.commit_cmdline))
;   (ix.charmap.set :i :<Tab> (ix.action.completion.commit {:select_first true}))
;   (vim.keymap.set :i :<C-y> (ix.action.completion.commit {:no_snippet true
;                                                           :replace true
;                                                           :select_first true})))

(let [(_ blink) (pcall require "blink.cmp")
      (_ snippy) (pcall require "snippy")]
  (blink.setup {:keymap {:preset "super-tab"
                         :<C-k> false
                         :<Tab> ["select_and_accept" "snippet_forward" "fallback"]}
                :snippets {:expand (fn [snippet] (snippy.expand_snippet snippet))
                           :active (fn [filter] (if (= filter nil)
                                                    nil
                                                    (~= filter nil)
                                                    (snippy.can_jump (. filter :direction))))
                           :jump (fn [direction] (if (= direction 1)
                                                     (snippy.next)
                                                     (= direction -1)
                                                     (snippy.previous)))}
                :cmdline {:keymap {:preset "inherit"}
                          :completion {:menu {:auto_show true}}}
                :appearance {:use_nvim_cmp_as_default true
                             :nerd_font_variant "mono"}
                :completion {:trigger {:prefetch_on_insert true}
                             :list {:selection {:preselect false}}
                             :accept {:dot_repeat false}}
                :sources {:default ["lsp" "path" "buffer"]}
                :signature {:enabled true}}))
