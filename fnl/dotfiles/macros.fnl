;; [nfnl-macro]

;; copy from Olical/aniseed
(fn autocmd [event opt]
  `(vim.api.nvim_create_autocmd
    ,event ,opt))

(fn autocmds [...]
  (var form `(do))
  (each [_ v (ipairs [...])]
    (table.insert form (autocmd (unpack v))))
  (table.insert form 'nil)
  form)

(fn augroup [name ...]
  (var cmds `(do))
  (var group (sym :group))
  (each [_ v (ipairs [...])]
    (let [(event opt) (unpack v)]
      (tset opt :group group)
      (table.insert cmds (autocmd event opt))))
  (table.insert cmds 'nil)
  `(let [,group
         (vim.api.nvim_create_augroup ,name {:clear true})]
     ,cmds))

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
     (vim.keymap.set ,modes ,lhs ,rhs opts#)))

{:autocmd autocmd
 :autocmds autocmds
 :augroup augroup
 :map map}
