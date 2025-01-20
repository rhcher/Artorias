(import-macros {: map} :dotfiles.macros)

(local layout_ivy {:layout {1 {:border :bottom :height 1 :win :input}
                            2 {1 {:border :none :win :list}
                               2 {:border :left
                                  :title "{preview}"
                                  :width 0.6
                                  :win :preview}
                               :box :horizontal}
                            :backdrop false
                            :border :top
                            :box :vertical
                            :height 0.4
                            :row (- 1)
                            :title " {title} {live} {flags}"
                            :title_pos :left
                            :width 0}})

(let [(_ snacks) (pcall require "snacks")]
  (snacks.setup {:indent {}
                 :picker {:layout layout_ivy}
                 :quickfile {}
                 :notifier {}}))

; picker keymap
(map :n :<leader>ff #(Snacks.picker.files))
(map :n :<leader>fp #(Snacks.picker.files {:cwd "~/.config/nvim"}))
(map :n :<leader>fs #(Snacks.picker.grep))
(map :n :<leader>fb #(Snacks.picker.buffers))
(map :n :<leader>bb #(Snacks.picker.buffers))
(map :n :<leader>fh #(Snacks.picker.help))
(map :n :<leader>fk #(Snacks.picker.keymaps))
; (map :n :<leader>fl fzf.blines)
; (map :n :<leader>pl fzf.lines)
; (map :n :<leader>fo fzf.oldfiles)
; (map :n :<leader>fc fzf.commands)
; (map :n :<leader>fq fzf.quickfix)
; (map :n :<leader>fg fzf.git_bcommits)

; notifier keymap
(map :n :<leader>nf #(Snacks.notifier.show_history))
