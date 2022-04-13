(module dotfiles.plugin.cmp
  {autoload {cmp cmp
             snippy snippy
             cmp_buffer cmp_buffer
             lspkind lspkind
             cmp_git cmp_git
             compare cmp.config.compare}})

(def- underline
  (fn [entry1 entry2]
    (var (_ entry1_under) (: entry1.completion_item.label :find "^_+"))
    (var (_ entry2_under) (: entry2.completion_item.label :find "^_+"))
    (set entry1_under (or entry1_under 0))
    (set entry2_under (or entry2_under 0))
    (if (> entry1_under entry2_under)
      false
      (< entry1_under entry2_under)
      true)))

(cmp.setup
  {:snippet {:expand (fn [args] (snippy.expand_snippet args.body))}
   :completion {:completeopt "menu,menuone,noselect"
                :keyword_pattern "\\k\\+"}
   :sorting {:comparators [compare.offset
                           compare.exact
                           compare.score
                           compare.recently_used
                           compare.locality
                           ;; cmp.config.compare.scopes
                           underline
                           compare.kind
                           compare.length
                           compare.sort_text
                           compare.order]}
   :experimental {:ghost_text true}
   :documentation {:winhighlight "NormalFloat:Pmenu,FloatBorder:Bold"}
   :mapping {:<C-d> (cmp.mapping.scroll_docs (- 4))
             :<C-f> (cmp.mapping.scroll_docs 4)
             :<C-space> (cmp.mapping.complete)
             :<C-e> (cmp.mapping.close)
             :<C-y> (cmp.mapping.confirm {:select true
                                          :behavior cmp.ConfirmBehavior.Replace})
             :<Tab> (cmp.mapping (fn [fallback]
                                   (if 
                                     (cmp.visible)
                                     (cmp.confirm {:select true
                                                   :behavior cmp.ConfirmBehavior.Insert})
                                     (snippy.can_expand_or_advance)
                                     (snippy.expand_or_advance)
                                     (fallback)))
                                 [:s :i :c])}
   :formatting {:fields [:kind :abbr :menu]
                :format (lspkind.cmp_format {:mode "symbol"
                                             :maxwidth 50
                                             :before (fn [entry vim_item]
                                                       (tset vim_item :dup (or (. {:conjure 0} entry.source.name) 0))
                                                       vim_item)})} 
   :sources (cmp.config.sources [{:name :nvim_lsp_signature_help}]
                                [{:name :path}]
                                [{:name :snippy
                                  :keyword_length 2}
                                 {:name :nvim_lsp}]
                                [{:name :conjure}]
                                [{:name :buffer
                                  :keyword_length 3
                                  :option {:keyword_pattern "\\k\\+"
                                           :get_bufnrs (fn []
                                                         (let [bufs {}]
                                                           (each [_ win (ipairs (vim.api.nvim_list_wins))]
                                                             (tset bufs (vim.api.nvim_win_get_buf win) true))
                                                           (vim.tbl_keys bufs)))}}])})

(cmp.setup.cmdline "/"
                   {:sources [{:name "buffer"}]})

(cmp.setup.cmdline ":"
                   {:sources [{:name "path"}
                              {:name "cmdline"}]})
