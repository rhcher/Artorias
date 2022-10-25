(module dotfiles.plugin.hydra)

(when-let [(_ hydra) (pcall require "hydra")]
  (do
    (hydra {:name "Side scroll"
            :mode :n
            :body :z
            :heads [[:h :5zh]
                    [:l :5zl {:desc "←/→"}]
                    [:H :zH]
                    [:L :zL {:desc "half screen ←/→"}]]})

    (when-let [(_ splits) (pcall require "smart-splits")]
      (hydra {:name "smooth scroll"
              :mode :n
              :body :<C-w>
              :heads [[:< splits.resize_left]
                      [:> splits.resize_right]
                      [:+ splits.resize_up]
                      [:- splits.resize_down]]}))))
