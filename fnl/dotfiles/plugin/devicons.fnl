(let [(_ devicons) (pcall require "nvim-web-devicons")]
  (let [fnl-custom {:icon "" :color "#e6b439" :cterm_color "65" :name "fennel"}
        fnl-alt {:icon "" :color "#7bc45c" :name "fennel"}]
    (devicons.set_icon {:fnl fnl-alt})))
