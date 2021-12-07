(module dotfiles.plugin.conjure
  {autoload {nvim aniseed.nvim}})

(set nvim.g.conjure#eval#result_register "*")
(set nvim.g.conjure#log#botright true)
(set nvim.g.conjure#mapping#doc_word "gk")

(set nvim.g.conjure#client#scheme#stdio#command "petite")
(set nvim.g.conjure#client#scheme#stdio#prompt_pattern "> $?")
(set nvim.g.conjure#client#scheme#stdio#value_prefix_pattern false)
; (set nvim.g.conjure#extract#tree_sitter#enabled true)
