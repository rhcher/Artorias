(import-macros {: map} :dotfiles.macros)

(let [(_ mini_file) (pcall require "mini.files")]
  (mini_file.setup))

(let [(_ mini_icon) (pcall require "mini.icons")]
  (mini_icon.setup))

(let [(_ mini_sessions) (pcall require "mini.sessions")]
  (mini_sessions.setup))

; (map :n :<leader>e #(MiniFiles.open))
