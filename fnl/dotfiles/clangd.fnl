(local {: autoload} (require "nfnl.module"))
(local util (autoload "vim.lsp.util"))
(local api vim.api)

; clangd AST

(fn handlers [err ASTNode]
  (when (and (not err) ASTNode)
    (vim.print (vim.inspect ASTNode))
    (vim.cmd.vsplit (string.format "%s: AST" ASTNode.detail))
    (local ast-buf (api.nvim_get_current_buf))
    (api.nvim_buf_set_lines ast-buf 0 0 false (vim.split (vim.inspect ASTNode) "\n"))))

(fn ast []
  (vim.lsp.buf_request 0 "textDocument/ast"
                       (util.make_range_params)
                       handlers))

; treesitter AST

{: ast}
