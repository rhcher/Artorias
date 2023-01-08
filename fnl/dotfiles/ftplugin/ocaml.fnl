(module dotfiles.ftplugin.ocaml
  {autoload {lsp dotfiles.plugin.lspconfig}})

(def language-id-of
  {:menhir "ocaml.menhir"
   :ocaml "ocaml"
   :ocamlinterface "ocaml.interface"
   :ocamllex "ocaml.ocamllex"
   :reason "reason"
   :dune "dune"})

(lsp.safe-start
  #(vim.lsp.start
     {:name "ocamllsp"
      :cmd ["ocamllsp"]
      :capabilities (lsp.capabilities)
      :root_dir (lsp.root-pattern ["*.opam" "esy.json" "package.json" ".git"
                                   "dune-project" "dune-workspace"])
      :get_language_id #(. language-id-of $2)}))
