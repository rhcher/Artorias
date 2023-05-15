(module dotfiles.plugin.lspsaga)

(when-let [(_ lspsaga) (pcall require "lspsaga")]
  (lspsaga.setup {:lightbulb {:sign_priority 99
                              :virtual_text false}
                  :symbol_in_winbar {:enable false}
                  :diagnostic {:on_insert false}
                  :hover {:open_link "gf"}
                  :outline {:keys {:jump "<CR>"
                                   :expand_collapse "o"}}
                  :ui {:border ["" "━" "" "" "" "━" "" ""]}}))
