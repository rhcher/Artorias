(vim.loader.enable)

(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(vim.lsp.log.set_level vim.log.levels.OFF)

(fn ensure [user repo]
  (let [lazypath (.. (vim.fn.stdpath :data) :/lazy/ repo)
        lazyrepo (string.format "https://github.com/%s/%s" user repo)]
    (when (not ((. (or vim.uv vim.loop) :fs_stat) lazypath))
      (local out (vim.fn.system [:git
                                 :clone
                                 "--filter=blob:none"
                                 "--single-branch"
                                 lazyrepo
                                 lazypath]))
      (when (not= vim.v.shell_error 0)
        (vim.api.nvim_echo [["Failed to clone lazy.nvim:\n" :ErrorMsg]
                            [out :WarningMsg]
                            ["\nPress any key to exit..."]]
                           true {})
        (vim.fn.getchar)
        (os.exit 1)))
    (vim.opt.rtp:prepend lazypath)))

(ensure :folke :lazy.nvim)
(ensure :Olical :nfnl)

((. (require :lazy) :setup) {:change_detection {:notify false}
                             :spec [{:import :plugins}]})

(require :config.mappings)
(require :config.options)
(require :config.diagnostics)
(require :config.lsp)
(require :config.code_action)
(require :config.fennel_indent)
