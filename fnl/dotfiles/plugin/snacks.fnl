(import-macros {: map} :dotfiles.macros)

(let [(_ snacks) (pcall require "snacks")]
  (snacks.setup {:indent {:animate {:style "down"}}
                 :picker {:layout {:preset "ivy"
                                   :cycle false}}
                 :terminal {}
                 :styles {}
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
