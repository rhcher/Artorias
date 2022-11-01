(module dotfiles.semanticTokens)

(local last-tick {})
(local last-successful-tick {})
(local active-requests {})

(defn- three-expr [a b c]
  (or (and a b) c))

(defn- get-bit [n k]
  (_G.bit.band (_G.bit.rshift n k) 1))

(defn- modifiers-from-number [x modifiers-table]
  (var modifiers {})
  (for [i 0 (- (length modifiers-table) 1)]
    (let [bit (get-bit x i)]
      (when (= bit 1)
        (table.insert modifiers 1 (. modifiers-table (+ i 1))))))
  modifiers)

(defn on-full [err result ctx config]
  (tset active-requests ctx.bufnr false)
  (local client (vim.lsp.get_client_by_id ctx.client_id))
  (when (or (not client)
            (not (vim.api.nvim_buf_is_loaded ctx.bufnr)))
    (lua "return "))
  (when (or err
            (not result)
            (not config.on_token)
            (not= (. last-tick ctx.bufnr) (vim.api.nvim_buf_get_changedtick ctx.bufnr)))
    (lua "return "))
  (when (and config config.on_invalidate_range)
    (config.on_invalidate_range ctx 0 -1))
  (let [legend client.server_capabilities.semanticTokensProvider.legend
        token-types legend.tokenTypes
        token-modifiers legend.tokenModifiers
        data result.data]
    (var line 0)
    (var start-char 0)
    (for [i 1 (length data) 5]
      (var delta-line (. data i))
      (set line (three-expr line (+ line delta-line) delta-line))
      (var delta-start (. data (+ i 1)))
      (set start-char (three-expr (= delta-line 0)
                                  (+ start-char delta-start)
                                  delta-start))
      (var token-type (. token-types (+ (. data (+ i 3)) 1)))
      (var modifiers (modifiers-from-number (. data (+ i 4)) token-modifiers))
      (local token {:line line
                    :start_char start-char
                    :length (. data (+ i 2))
                    :type token-type
                    :modifiers modifiers
                    :offset_encoding client.offset_encoding})
      (when (and token-type config config.on_token)
        (config.on_token ctx token))))
  (tset last-successful-tick ctx.bufnr (. last-tick ctx.bufnr)))

(defn on-refresh [err _ ctx _]
  (when (not err)
    (each [_ bufnr (ipairs (vim.lsp.get_buffers_by_client_id ctx.client_id))]
      (refresh bufnr)))
  vim.NIL)

(defn- save-tick [bufnr]
  (tset last-tick bufnr (vim.api.nvim_buf_get_changedtick bufnr))
  (tset active-requests bufnr true))

(defn refresh [bufnr]
  (vim.validate {:bufnr [bufnr "number"]})
  (var bufnr bufnr)
  (when (= bufnr 0)
    (set bufnr (vim.api.nvim_get_current_buf)))
  (when (not (. active-requests bufnr))
    (let [params {:textDocument {:uri (vim.uri_from_bufnr bufnr)}}]
      (when (or (not (. last-successful-tick bufnr))
                (< (. last-successful-tick bufnr)
                   (vim.api.nvim_buf_get_changedtick bufnr)))
        (save-tick bufnr)
        (vim.lsp.buf_request bufnr "textDocument/semanticTokens/full" params)))))

(defn extend-capabilities [caps]
  (set caps.textDocument.semanticTokens
       {:dynamicRegistration false
        :tokenTypes ["namespace"
                     "type"
                     "class"
                     "enum"
                     "interface"
                     "struct"
                     "typeParameter"
                     "parameter"
                     "variable"
                     "property"
                     "enumMember"
                     "event"
                     "function"
                     "method"
                     "macro"
                     "keyword"
                     "modifier"
                     "comment"
                     "string"
                     "number"
                     "regexp"
                     "operator"
                     "decorator"]
        :tokenModifiers ["declaration"
                         "definition"
                         "readonly"
                         "static"
                         "deprecated"
                         "abstract"
                         "async"
                         "modification"
                         "documentation"
                         "defaultLibrary"]
        :formats ["relative"]
        :requests {:full {:delta false}}
        :overlappingTokenSupport true
        :multilineTokenSupport false})
  caps)

(def- ns (vim.api.nvim_create_namespace "nvim-semantic-tokens"))
(def- defined-hl {})

(defn- chain-link-hl [hl-tbl hl-name]
  (when (. defined-hl hl-name)
    (lua "return"))
  (table.remove hl-tbl)
  (local hl-base-name (three-expr (next hl-tbl)
                                  (.. "Lsp." (table.concat hl-tbl "."))
                                  nil))
  (vim.api.nvim_set_hl 0 hl-name {:default true :link hl-base-name})
  (set defined-hl.hl-name true)
  (when hl-base-name
    (chain-link-hl hl-tbl hl-base-name)))

(defn- resolve-hl [token]
  (var hl nil)
  (if token.modifiers
    (set hl [token.type (unpack token.modifiers)])
    (set hl [token.type]))
  (let [hl-name (.. "Lsp." (table.concat hl "."))]
    (chain-link-hl hl hl-name)
    hl-name))

(defn- on-token [ctx token]
  (let [linenr token.line
        start-col (vim.fn.virtcol2col 0 (+ linenr 1) token.start_char)
        end-col (vim.fn.virtcol2col 0 (+ linenr 1) (+ token.start_char token.length))]
    (when (and (>= start-col 0)
               (>= end-col 0))
      (let [hl (resolve-hl token)]
        (vim.api.nvim_buf_set_extmark ctx.bufnr
                                      ns
                                      linenr
                                      start-col
                                      {:end_col (math.min end-col
                                                          (length (vim.fn.getline (+ linenr
                                                                                     1))))
                                       :hl_group hl
                                       :priority 110})))))

(defn- clear-highlights [ctx line-start line-end]
  (vim.api.nvim_buf_clear_namespace ctx.bufnr ns line-start line-end))

(tset vim.lsp.handlers
      "textDocument/semanticTokens/full"
      (vim.lsp.with on-full
                    {:on_token on-token
                     :on_invalidate_range clear-highlights}))

(fn vim.lsp.buf.semantic_tokens_full []
  (let [params {:textDocument (vim.lsp.util.make_text_document_params)}]
    (save-tick (vim.api.nvim_get_current_buf))
    (vim.lsp.buf_request 0 "textDocument/semanticTokens/full" params)))

(fn vim.lsp.buf.semantic_tokens_range [start-pos end-pos]
  (let [params (vim.lsp.util.make_given_range_params start-pos end-pos)]
    (vim.lsp.buf_request
      0
      "textDocument/semanticTokens/range"
      params
      (vim.lsp.with on-full
                    {:on_token
                     (fn [ctx token]
                       (vim.notify (.. token.type
                                       "."
                                       (table.concat token.modifiers "."))))}))))

(defn make-highlights [hl-map]
  (each [key val (pairs hl-map)]
    (if (= (type val) "table")
      (each [k v (pairs val)]
        (let [name (.. key (three-expr (= (type k) "number")
                                       ""
                                       (.. "." k)))]
          (make-highlights {name v})))
      (vim.api.nvim_set_hl 0 (.. "Lsp." key) {:link val}))))

(def hl-map
  {:namespace "@namespace"
   :type "Type"
   :class "Type"
   :enum "Type"
   :interface "Type"
   :struct "Type"
   :typeParameter "Type"
   :parameter "Identifier"
   :variable {1 "LspCxxHlSymVariable"
              :static "Constant"
              :readonly "Constant"
              :defaultLibrary "LspCxxHlSymVariable"}
   :property "@field"
   :enumMember "LspEnumMember"
   :event "Type"
   :function {1 "@function"
              :definition "Function"
              :defaultLibrary "@function"
              :static "Function"}
   :method "@function"
   :macro "Macro"
   :keyword {1 "Keyword"
             :documentation "@attribute"}
   :comment "Comment"
   :string "String"
   :number "Number"
   :regexp "@string.regex"
   :operator "Operator"})

(make-highlights hl-map)
