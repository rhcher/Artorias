(local {: autoload} (require :nfnl.module))
(local util (autoload :dotfiles.util))

(local underline
  (fn [entry1 entry2]
    (var (_ entry1_under) (: entry1.completion_item.label :find "^_+"))
    (var (_ entry2_under) (: entry2.completion_item.label :find "^_+"))
    (set entry1_under (or entry1_under 0))
    (set entry2_under (or entry2_under 0))
    (if (> entry1_under entry2_under)
        false
        (< entry1_under entry2_under)
        true)))

(local cmp-window-opts {:border :single
                        :winhighlight "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None"})

(local cmp-buffer {:name :buffer
                   :option {:keyword_length 3
                            :keyword_pattern "\\k\\+"
                            :get_bufnrs #(let [bufs {}]
                                           (each [_ win (ipairs (vim.api.nvim_list_wins))]
                                             (tset bufs (vim.api.nvim_win_get_buf win) true))
                                           (vim.tbl_keys bufs))}})

(let [(ok? cmp) (pcall require :cmp)
      snippy (require :snippy)
      lspkind (require :lspkind)]
  (when ok?
    (cmp.setup
      {:snippet {:expand (fn [args] (snippy.expand_snippet args.body))}
       :performance {:debounce 20}
       :completion {:completeopt "menu,menuone,noselect"
                    :keyword_pattern "\\k\\+"}
       ; :view {:entries {:follow_cursor true}}
       :sorting {:comparators [cmp.config.compare.offset
                               cmp.config.compare.exact
                               cmp.config.compare.score
                               cmp.config.compare.recently_used
                               cmp.config.compare.locality
                               cmp.config.compare.length
                               cmp.config.compare.order]}
       ; :experimental {:ghost_text {:hl_group "LspCodeLens"}}
       :window {:documentation cmp-window-opts
                :completion cmp-window-opts}
       :mapping (cmp.mapping.preset.insert {:<C-d> (cmp.mapping.scroll_docs (- 4))
                                            :<C-f> (cmp.mapping.scroll_docs 4)
                                            :<C-space> (cmp.mapping.complete)
                                            :<C-e> (cmp.mapping.close)
                                            :<C-y> (cmp.mapping.confirm {:select true
                                                                         :behavior cmp.ConfirmBehavior.Replace})
                                            :<Tab> (cmp.mapping (fn [fallback]
                                                                  (if (cmp.visible)
                                                                      (cmp.confirm {:select true
                                                                                    :behavior cmp.ConfirmBehavior.Insert})
                                                                      (snippy.can_expand_or_advance)
                                                                      (snippy.expand_or_advance)
                                                                      (fallback)))
                                                                [:s :i :c])})
       :formatting {:fields [:kind :abbr :menu]
                    :format (lspkind.cmp_format {:mode "symbol"
                                                 :maxwidth 50
                                                 :before (fn [entry vim_item]
                                                           (tset vim_item :dup (or (. {:conjure 0} entry.source.name) 0))
                                                           vim_item)})}
       :sources (cmp.config.sources [{:name :nvim_lsp}])})
                                    ; [{:name :path}
                                    ;  cmp-buffer])})
    (cmp.setup.filetype [:fennel :lisp :scheme :clojure :janet :timl]
                        {:sources [{:name "conjure"}
                                   {:name "path"}
                                   cmp-buffer]})
    (cmp.setup.cmdline "/"
                       {:mapping (cmp.mapping.preset.cmdline)
                        :sources [{:name "buffer"}]})
    (cmp.setup.cmdline ":"
                       {:mapping (cmp.mapping.preset.cmdline)
                        :sources (cmp.config.sources [{:name "cmdline"}]
                                                     [{:name "path"}])})))
