(let [(_ bqf) (pcall require :bqf)]
  (bqf.setup {:preview {:auto_preview false
                        :border_chars [" " " " "━" "━" " " " " " " " " "█"]}
              :auto_resize_height true}))
