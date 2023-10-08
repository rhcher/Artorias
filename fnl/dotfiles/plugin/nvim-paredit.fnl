(let [paredit (require "nvim-paredit")
      paredit-fennel (require "nvim-paredit-fennel")]
  (paredit.setup {:keys {:<localleader>w [#(paredit.cursor.place_cursor
                                             (paredit.wrap.wrap_element_under_cursor "( " ")")
                                             {:placement "inner_start"
                                              :mode "insert"})
                                          "Wrap element insert head"]
                         :<localleader>W [#(paredit.cursor.place_cursor
                                             (paredit.wrap.wrap_element_under_cursor "(" " )")
                                             {:placement "inner_end"
                                              :mode "insert"})
                                          "Wrap element insert tail"]
                         :<localleader>i [#(paredit.cursor.place_cursor
                                             (paredit.wrap.wrap_enclosing_form_under_cursor "( " ")")
                                             {:placement "inner_start"
                                              :mode "insert"})
                                          "Wrap form insert head"]
                         :<localleader>I [#(paredit.cursor.place_cursor
                                             (paredit.wrap.wrap_enclosing_form_under_cursor "(" " )")
                                             {:placement "inner_end"
                                              :mode "insert"})
                                          "Wrap form insert tail"]}})
  (paredit-fennel.setup))
