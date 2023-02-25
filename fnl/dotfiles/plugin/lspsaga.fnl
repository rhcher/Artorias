(module dotfiles.plugin.lspsaga)

(when-let [(_ lspsaga) (pcall require "lspsaga")]
  (lspsaga.setup {:lightbulb {:sign_priority 99
                              :virtual_text false}
                  :symbol_in_winbar {:enable true}
                  :diagnostic {:on_insert false}
                  :outline {:keys {:jump "<CR>"
                                   :expand_collapse "o"}}
                  :ui {:border ["" "━" "" "" "" "━" "" ""]
                       :colors {:normal_bg "#121212"
                                :title_bg "#FBB829"
                                :red "#EF2F27"
                                :magenta "#E02C6D"
                                :orange "#FF5F00"
                                :yellow "#FBB829"
                                :green "#519F50"
                                :cyan "#0AAEB3"
                                :blue "#2C78BF"
                                :white "#BAA67F"
                                :black "#1C1B19"}}}))
