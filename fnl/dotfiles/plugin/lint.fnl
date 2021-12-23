(module dotfiles.plugin.lint
  {autoload {lint lint}})

(set lint.linters_by_ft {:cpp [:clangtidy]})

(vim.cmd "au BufWritePost <buffer> lua require('lint').try_lint()")
