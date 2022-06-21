(module dotfiles.indentation)
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
                 "defn-" true "defn" true "def" true "def-" true
                 "defonce" true "defonce-" true
                 "macro" true "match" true "doto" true "with-open" true
                 "collect" true "icollect" true "accumulate" true})

(fn symbol-at [line pos]
  (: (line:sub pos) :match "[^%s]+"))

(fn find-string-start [line end-quote-pos]
  (var quote-pos nil)
  (var state :in-string)
  (for [i (- end-quote-pos 1) 1 -1 :until (= state :none)]
    (match (values (line:sub i i) state)
      ("\"" _) (do (set quote-pos (- i 1))
                   (set state :maybe-quote))
      ("\\" :maybe-quote) (set state :escaped-quote)
      ("\\" :escaped-quote) (set state :maybe-quote)
      (_ :maybe-quote) (set state :none)
      _ (set state :in-string)))
  quote-pos)

(fn line-indent-type [line i stack]
  (let [c (line:sub i i)
        delimiter (. stack (length stack))]
    (if (= i 0) nil
        (= c "\"") (let [string-start (find-string-start line i)]
                     (when string-start
                       (line-indent-type line string-start stack)))
        ;; if we find the delimiter we're looking for, stop looking
        (= c delimiter) (do (table.remove stack)
                            (line-indent-type line (- i 1) stack))
        ;; if we find a new form, start looking for the delimiter that begins it
        (. delimiters c) (do (table.insert stack (. delimiters c))
                             (line-indent-type line (- i 1) stack))
        ;; if we're looking for a delimiter, skip everything till we find it
        delimiter (line-indent-type line (- i 1) stack)
        ;; if we hit an opening table char, we're in a table!
        (or (= c "[") (= c "{")) (values :table i)
        ;; if we hit an open paren, we're in a call!
        (= c "(") (values :call i (symbol-at line (+ i 1)))
        (line-indent-type line (- i 1) stack))))

(fn find-comment-start [line]
  (var semicolon-pos nil)
  (var state :none)
  (for [i 1 (length line) :until semicolon-pos]
    (match (values (line:sub i i) state)
      (";" :none) (set semicolon-pos (- i 1))
      (_ :escaping) (set state :in-string)
      ("\\" :in-string) (set state :escaping)
      ("\"" :in-string) (set state :none)
      ("\"" :none) (set state :in-string)))
  semicolon-pos)

(fn indent-type [lines line-num stack]
  (let [line (. lines line-num)
        line-length (or (find-comment-start line) (length line))]
    (match (line-indent-type line line-length stack)
      (:table i) (values :table i)
      (:call i fn-name) (if (. specials fn-name)
                            (values :special (- i 1))
                            (= (- (length line) i) (length fn-name))
                            (values :special (- i 1))
                            (values :call (- i 1) fn-name))
      (where _ (> line-num 1)) (indent-type lines (- line-num 1) stack))))

(fn _G.fennel_indentexpr [line-num]
  (let [lines (vim.api.nvim_buf_get_lines 0 0 line-num true)]
    (match (indent-type lines (- line-num 1) [])
      (:table delimiter-pos) delimiter-pos
      (:special prev-indent) (+ prev-indent 2)
      (:call prev-indent fn-name) (+ prev-indent (length fn-name) 2)
      _ 0)))

(fn fennel_local []
  (set vim.opt_local.softtabstop 2)
  (set vim.opt_local.indentkeys ["!" :o :O])
  (vim.opt_local.formatoptions:remove :t)
  (set vim.opt_local.iskeyword
       ["33-255" "^(" "^)" "^{" "^}" "^[" "^]" "^\"" "^'" "^~" "^;" "^," "^@-@" "^`" "^." "^:"])
  (set vim.opt_local.indentexpr "v:lua.fennel_indentexpr(v:lnum)"))

(vim.api.nvim_create_autocmd [:FileType]
                             {:pattern :fennel
                              :callback fennel_local})
