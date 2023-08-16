(vim.loader.enable)
(local lazypath (.. (vim.fn.stdpath :data) "/lazy"))

(fn ensure [user repo]
  (let [install-path (string.format "%s/%s" lazypath repo)]
    (when (> (vim.fn.empty (vim.fn.glob install-path)) 0)
      (vim.api.nvim_command
        (string.format
          "!git clone --filter=blob:none --single-branch https://github.com/%s/%s %s"
          user
          repo
          install-path)))
    (vim.opt.runtimepath:prepend install-path)))

(ensure :folke :lazy.nvim)
(ensure :Olical :nfnl)

(require :dotfiles.init)

(vim.cmd "let g:loaded_netrwPlugin = 1")
(vim.cmd "let g:loaded_tarPlugin = 1")
(vim.cmd "let g:loaded_tutor_mode_plugin = 1")
(vim.cmd "let g:loaded_zipPlugin = 1")
(vim.cmd "let g:loaded_gzip = 1")
(vim.cmd "let g:loaded_2html_plugin = 1")
(vim.cmd "let g:loaded_matchit=1")
(vim.cmd "let g:loaded_matchparen=1")
(vim.cmd "let g:loaded_python_provider = 0")
(vim.cmd "let g:loaded_python3_provider = 0")
(vim.cmd "let g:loaded_node_provider = 0")
(vim.cmd "let g:loaded_perl_provider = 0")
