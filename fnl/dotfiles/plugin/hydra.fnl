(module dotfiles.plugin.hydra
  {autoload {: hydra
             :splits :smart-splits}})

(hydra {:name "Side scroll"
        :mode :n
        :body :z
        :heads [[:h :5zh]
                [:l :5zl {:desc "←/→"}]
                [:H :zH]
                [:L :zL {:desc "half screen ←/→"}]]})

(hydra {:name "smooth scroll"
        :mode :n
        :body :<C-w>
        :heads [[:< splits.resize_left]
                [:> splits.resize_right]
                [:+ splits.resize_up]
                [:- splits.resize_down]]})
