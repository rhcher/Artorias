(import-macros {: map} :dotfiles.macros)

(local sections [{:section :header}
                 {:cmd "~/square"
                  :height 5
                  :padding 1
                  :pane 2
                  :section :terminal}
                 {:gap 1 :padding 1 :section :keys}
                 {:icon " "
                  :indent 2
                  :padding 1
                  :pane 2
                  :section :recent_files
                  :title "Recent Files"}
                 {:icon " "
                  :indent 2
                  :padding 1
                  :pane 2
                  :section :projects
                  :title :Projects}
                 {:cmd "git status --short --branch --renames"
                  :enabled (fn [] (not= (Snacks.git.get_root) nil))
                  :height 5
                  :icon " "
                  :indent 3
                  :padding 1
                  :pane 2
                  :section :terminal
                  :title "Git Status"
                  :ttl (* 5 60)}
                 {:section :startup}])  

(let [(_ snacks) (pcall require "snacks")]
  (snacks.setup {:indent {:animate {:style "down"}}
                 :picker {:layout {:preset "ivy"
                                   :cycle false}}
                 :terminal {}
                 :styles {}
                 :dashboard {:sections sections}
                 :images {}
                 :quickfile {}
                 :notifier {}}))

; picker keymap
(map :n :<leader>ff #(Snacks.picker.files))
(map :n :<leader>fc #(Snacks.picker.files {:cwd "~/.config/nvim"}))
(map :n :<leader>fs #(Snacks.picker.grep))
(map :n :<leader>fb #(Snacks.picker.buffers))
(map :n :<leader>bb #(Snacks.picker.buffers))
(map :n :<leader>fh #(Snacks.picker.help))
(map :n :<leader>fk #(Snacks.picker.keymaps))
(map :n :<leader>fl #(Snacks.picker.lines))
(map :n :<leader>fp #(Snacks.picker.projects))
(map :n :<leader>ss #(Snacks.picker.smart))
(map :n :<leader>su #(Snacks.picker.undo))
(map :n :<leader>sh #(Snacks.picker.highlights))
; (map :n :<leader>pl fzf.lines)
; (map :n :<leader>fo fzf.oldfiles)
; (map :n :<leader>fc fzf.commands)
; (map :n :<leader>fq fzf.quickfix)
; (map :n :<leader>fg fzf.git_bcommits)

; notifier keymap
(map :n :<leader>nf #(Snacks.notifier.show_history))
(map :n :<leader>ot #(Snacks.terminal))
