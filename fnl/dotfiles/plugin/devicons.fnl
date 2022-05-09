(module dotfiles.plugin.devicons
  {autoload {devicons nvim-web-devicons}})

(let [fnl-custom {:icon "" :color "#e6b439" :name "fennel"}
      fnl-alt {:icon "" :color "#7bc45c" :name "fennel"}]
  (devicons.setup
    {:default true
     :override {:fnl fnl-alt
                :fennel fnl-alt}}))
