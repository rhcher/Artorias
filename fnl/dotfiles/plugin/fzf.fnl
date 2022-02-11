(module dotfiles.plugin.fzf
  {autoload {fzf "fzf-lua"}})

(fzf.setup {:winopts {:split "belowright new"
                      :border "single"}})

(let [map (fn [key func]
            (vim.keymap.set :n (.. :<leader> key) func {:noremap true :silent true}))]
  (map :ff fzf.files)
  (map :fp (fn [] (fzf.files {:cwd "~/.config/nvim/"})))
  (map :fs fzf.live_grep_native)
  (map :fb fzf.buffers)
  (map :bb fzf.buffers)
  (map :fh fzf.help_tags)
  (map :fk fzf.keymaps)
  (map :fL fzf.blines)
  (map :fl fzf.lines)
  (map :fo fzf.oldfiles)
  (map :fc fzf.commands)
  (map :fq fzf.quickfix)
  (map :fg fzf.git_bcommits))
