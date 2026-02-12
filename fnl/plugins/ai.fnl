(import-macros {: tx} :config.macros)

(tx "folke/sidekick.nvim"
  {:keys [{1 :<leader>aa
           2 #((. (require :sidekick.cli) :toggle))
           :desc "Sidekick Toggle CLI"}
          {1 :<leader>as
           2 #((. (require :sidekick.cli) :select) {:filter {:installed true}})
           :desc "Sidekick Select CLI"}
          {1 :<leader>at
           2 #((. (require :sidekick.cli) :send) {:msg "{this}"})
           :desc "Send this"
           :mode [:x :n]}
          {1 :<leader>av
           2 #((. (require :sidekick.cli) :send) {:msg "{selection}"})
           :desc "Send Visual Selection"
           :mode [:x]}
          {1 :<leader>ap
           2 #((. (require :sidekick.cli) :prompt))
           :desc "Sidekick Select Prompt"
           :mode [:n :x]}
          {1 :<c-.>
           2 #((. (require :sidekick.cli) :focus))
           :desc "Sidekick Switch Focus"
           :mode [:n :x :i :t]}]
   :opts {:cli {:mux {:backend :zellij :enabled false}}}})
