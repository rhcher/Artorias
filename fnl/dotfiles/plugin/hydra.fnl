(module dotfiles.plugin.hydra
  {autoload {: hydra}})

(hydra {:name "Side scroll"
        :mode :n
        :body :z
        :heads [[:h :5zh]
                [:l :5zl {:desc "←/→"}]
                [:j :5j]
                [:k :5k]
                [:H :zH]
                [:L :zL {:desc "half screen ←/→"}]]})

(hydra {:name "smooth scroll"
        :mode :n
        :body :<C-w>
        :heads [[:+ :<C-w>+]
                [:- :<C-w>-]
                [:> :<C-w><]
                [:< :<C-w>>]]})
