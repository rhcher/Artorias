(module dotfiles.plugin.cmp
  {autoload {nvim aniseed.nvim
             cmp cmp
             snippy snippy
             cmp_buffer cmp_buffer
             lspkind lspkind}})

(def- cmp-srcs
  [{:name :nvim_lsp}
   {:name :snippy
    :keyword_length 2}
   {:name :buffer
    :keyword_length 3
    :option {:keyword_pattern "\\k\\+"
             :get_bufnrs (fn []
                           (let [bufs {}]
                             (each [_ win (ipairs (vim.api.nvim_list_wins))]
                               (tset bufs (vim.api.nvim_win_get_buf win) true))
                             (vim.tbl_keys bufs)))}}
   {:name :conjure}
   {:name :path}])

(cmp.setup
  {:snippet {:expand (fn [args] (snippy.expand_snippet args.body))}
   :completion {:completeopt "menu,menuone,noselect"
                :keyword_pattern "\\k\\+"}
   :sorting {:comparators [cmp.config.compare.offset
                           cmp.config.compare.exact
                           cmp.config.compare.score
                           cmp.config.compare.recently_used
                           (fn [...] (cmp_buffer:compare_locality ...))
                           cmp.config.compare.kind
                           cmp.config.compare.length
                           cmp.config.compare.sort_text
                           cmp.config.compare.order]}
   :experimental {:ghost_text true}
   :documentation {:board "single"}
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
                                                   :behavior cmp.ConfirmBehavior.Replace})
                                     (snippy.can_expand_or_advance)
                                     (snippy.expand_or_advance)
                                     (fallback)))
                                 [:s :i :c])}
   :formatting {:fields [:kind :abbr :menu]
                :format (lspkind.cmp_format {:with_text false
                                             :maxwidth 50
                                             :before (fn [entry vim_item]
                                                       (tset vim_item :dup (or (. {:conjure 0 :nvim_lsp 0} entry.source.name) 0))
                                                       vim_item)})} 
   :sources cmp-srcs})

(cmp.setup.cmdline "/"
                   {:sources [{:name "buffer"}]})

(cmp.setup.cmdline ":"
                   {:sources [{:name "path"}
                              {:name "cmdline"}]})
