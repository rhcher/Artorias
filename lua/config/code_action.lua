-- [nfnl] fnl/config/code_action.fnl
vim.fn.sign_define("CodeAction", {text = "\240\159\146\161", texthl = "Question"})
local function update_signs()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({bufnr = bufnr, method = "textDocument/codeAction"})
  if not next(clients) then
    return
  else
  end
  local function _2_(client)
    local params = vim.lsp.util.make_range_params(vim.api.nvim_get_current_win(), client.offset_encoding)
    local context = {}
    context.triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked
    local ns_push = vim.lsp.diagnostic.get_namespace(client.id, false)
    local ns_pull = vim.lsp.diagnostic.get_namespace(client.id, true)
    local diagnostics = {}
    vim.list_extend(diagnostics, vim.diagnostic.get(bufnr, {namespace = ns_pull}))
    vim.list_extend(diagnostics, vim.diagnostic.get(bufnr, {namespace = ns_push}))
    local function _3_(d)
      return d.user_data.lsp
    end
    params.context = vim.tbl_extend("force", context, {diagnostics = vim.tbl_map(_3_, diagnostics)})
    return params
  end
  local function _4_(result)
    local _let_5_ = result[1]
    local context = _let_5_.context
    local result0 = _let_5_.result
    if not next(result0) then
      return
    else
    end
    local _let_7_ = result0[1]
    local command = _let_7_.command
    local kind = _let_7_.kind
    local title = _let_7_.title
    if not next(command) then
      return
    else
    end
    local arguments = command.arguments
    local command0 = command.command
    local title0 = command.title
    local _let_9_ = arguments[1]
    local selection = _let_9_.selection
    local start = selection.start
    local _end = selection["end"]
    local line = (start.line + 1)
    return vim.fn.sign_place(line, "CodeActionGroup", "CodeAction", bufnr, {lnum = line})
  end
  return vim.lsp.buf_request_all(bufnr, "textDocument/codeAction", _2_, _4_)
end
return vim.api.nvim_create_autocmd({"DiagnosticChanged"}, {group = vim.api.nvim_create_augroup("CodeActionSign", {clear = false}), callback = update_signs})
