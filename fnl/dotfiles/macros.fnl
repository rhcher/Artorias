{:augroup
 (fn [name ...]
    `(do
        (nvim.ex.augroup ,(tostring name))
        (nvim.ex.autocmd_)
        ,(list `do ...)
        (nvim.ex.augroup :END)))

 :autocmd
 (fn [...]
    `(nvim.ex.autocmd ,...))

 :_:
 (fn [name ...]
    `((. nvim.ex ,(tostring name)) ,...))

 :map
 (fn map [modes lhs rhs ?opt]
   (assert-compile (or (= (type modes) :string) (sequence? modes)) "mode must be string or list" modes)
   (assert-compile (= (type lhs) :string) "lhs must be string" lhs)
   (assert-compile (or (= nil ?opt) (table? ?opt)) "?opt must be a table" ?opt)
   `(let [opts# (collect [k# v# (pairs (or ,?opt {}))]
                  (values k# v#))]
      (when (= opts#.noremap nil)
        (set opts#.noremap true))
      (when (= opts#.silent nil)
        (set opts#.silent true))
      (vim.keymap.set ,modes ,lhs ,rhs opts#)))}

 ;; :viml->fn
 ;; (fn [name
 ;;       `(.. "lua require('" *module-name* "')['" ,(tostring name) "']()")])}
