(module dotfiles.plugin.project
  {autoload {nvim aniseed.nvim
             project project_nvim}})

(project.setup {:patterns [".git" "_darcs" ".hg" ".bzr"
                           ".svn" "Makefile" "package.json"
                           "stack.yaml" "dune-project" ".ccls-root"
                           "Cargo.toml"]})
