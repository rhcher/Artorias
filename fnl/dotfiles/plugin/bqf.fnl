(let [(_ bqf) (pcall require :bqf)]
  (bqf.setup {:preview {:auto_preview false
                        :border [" " "━" " " " " " " "━" " " " "]
                        :winblend 0}
              :auto_resize_height true}))
