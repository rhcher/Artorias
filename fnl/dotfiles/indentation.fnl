;; This format logic code is from fnlfmt
;; and the way to integrate to nvim is from
;; https://github.com/otommod/dotfiles/blob/main/nvim/.config/nvim/fnl/rc.fnl

(import-macros {: autocmd} :dotfiles.macros)

;; This contains heuristic-based functionality which can indent Fennel code
;; without fully parsing it. This can be useful in text editors when you can't
;; always guarantee that the contents are well-formed; they could be in the
;; middle of being edited.
;; Roughly the strategy is to find whether the current line is part of a table,
;; a "body" special form call, a regular function call, or none of the above.
;; Each of these are indented differently.
;;
;; Examples:
;;
;; (local table-type {:a 1
;;                    :b 2
;;                    :c 3})
;;
;; (when body-type?
;;   (print "This form is indented in body type."))
;;
;; (local regular-call (this-is indented-as
;;                              a-regular "function call"))
;;
;; "this is none of the above."

(local delimiters {")" "(" "]" "[" "}" "{"})
(local specials {"let" true "fn" true "lambda" true "λ" true "when" true
                 "eval-compiler" true "for" true "each" true "while" true
                 "import-macros" true "local" true
                 "macro" true "match" true "doto" true "with-open" true
                 "collect" true "icollect" true "accumulate" true})

(fn symbol-at [line pos]
  (-> line
      (: :sub pos)
      (: :match "[^%s]+")))

(fn find-string-start [line end-quote-pos]
  (var quote-pos nil)
  (var state :in-string)
  (for [pos (- end-quote-pos 1) 1 -1 &until (= state :end)]
    (match (values (line:sub pos pos) state)
      ("\"" _) (do (set quote-pos (- pos 1))
                   (set state :maybe-quote))
      ("\\" :maybe-quote) (set state :escaped-quote)
      ("\\" :escaped-quote) (set state :maybe-quote)
      (_ :maybe-quote) (set state :end)
      _ (set state :in-string)))
  quote-pos)

(fn line-indent-type [stack line pos]
  (let [c (line:sub pos pos)
        delimiter (. stack (length stack))]
    (if (= pos 0) nil
        ;; if we find a new string, try finding its starting quote
        (= c "\"") (let [string-start (find-string-start line pos)]
                     (when string-start
                       (line-indent-type stack line string-start)))
        ;; if we find the delimiter we're looking for, stop looking
        (= c delimiter) (do (table.remove stack)
                            (line-indent-type stack line (- pos 1)))
        ;; if we find a new form, start looking for the delimiter that begins it
        (. delimiters c) (do (table.insert stack (. delimiters c))
                             (line-indent-type stack line (- pos 1)))
        ;; if we're looking for a delimiter, skip everything till we find it
        delimiter (line-indent-type stack line (- pos 1))
        ;; if we hit an opening table char, we're in a table!
        (or (= c "[") (= c "{")) (values :table pos)
        ;; if we hit an open paren, we're in a call!
        (= c "(") (values :call pos (symbol-at line (+ pos 1)))
        (line-indent-type stack line (- pos 1)))))

(fn find-comment-start [line]
  (var semicolon-pos nil)
  (var state :normal)
  (for [pos 1 (length line) &until semicolon-pos]
    (match (values (line:sub pos pos) state)
      (";" :normal) (set semicolon-pos (- pos 1))
      (_ :escaping) (set state :in-string)
      ("\\" :in-string) (set state :escaping)
      ("\"" :in-string) (set state :normal)
      ("\"" :normal) (set state :in-string)))
  semicolon-pos)

(fn indent_type [stack lines line-num]
  (let [line (. lines line-num)
        line-length (or (find-comment-start line) (length line))]
    (match (line-indent-type stack line line-length)
      (:table pos) (values :table pos)
      (:call pos fn-name) (if (. specials fn-name)
                              (values :special (- pos 1))
                              (= (- (length line) pos) (length fn-name))
                              (values :special (- pos 1))
                              (values :call (- pos 1) fn-name))
      (where _ (> line-num 1)) (indent_type stack lines (- line-num 1)))))

(fn fennel_indentexpr [line-num]
  (let [lines (vim.api.nvim_buf_get_lines 0 0 line-num true)]
    (if (= line-num 1)
        0
        (match (indent_type [] lines (- line-num 1))
          (:table delimiter-pos) delimiter-pos
          (:special prev-indent) (+ prev-indent 2)
          (:call prev-indent fn-name) (+ prev-indent (length fn-name) 2)
          _ 0))))

(fn fennel-local []
  (set vim.opt_local.iskeyword ["33-255" "^(" "^)" "^{" "^}" "^[" "^]" "^\"" "^'" "^~" "^;" "^," "^@-@" "^`" "^:"])
  (set vim.opt_local.indentexpr "v:lua.require(\"dotfiles.indentation\").fennel_indentexpr(v:lnum)"))

(autocmd [:FileType] {:pattern "fennel" :callback #(fennel-local)})

{: indent_type
 : fennel_indentexpr}
