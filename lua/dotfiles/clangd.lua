-- [nfnl] fnl/dotfiles/clangd.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local util = autoload("vim.lsp.util")
local api = vim.api
local function handlers(err, ASTNode)
  if (not err and ASTNode) then
    vim.print(vim.inspect(ASTNode))
    vim.cmd.vsplit(string.format("%s: AST", ASTNode.detail))
    local ast_buf = api.nvim_get_current_buf()
    return api.nvim_buf_set_lines(ast_buf, 0, 0, false, vim.split(vim.inspect(ASTNode), "\n"))
  else
    return nil
  end
end
local function ast()
  return vim.lsp.buf_request(0, "textDocument/ast", util.make_range_params(), handlers)
end
return {ast = ast}
