(module dotfiles.plugin.conjure)

(set vim.g.conjure#eval#result_register "*")
(set vim.g.conjure#log#botright true)
;; (set vim.g.conjure#mapping#doc_word "gk")

(set vim.g.conjure#client#scheme#stdio#command "petite")
(set vim.g.conjure#client#scheme#stdio#prompt_pattern "> $?")
(set vim.g.conjure#client#scheme#stdio#value_prefix_pattern false)
(set vim.g.conjure#extract#tree_sitter#enabled false)
