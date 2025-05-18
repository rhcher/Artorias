-- [nfnl] fnl/dotfiles/ccls.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("vim.lsp.util")
local api = vim.api
local function handler(title)
  local function _2_(_, result, ctx, _0)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if ((result == nil) or vim.tbl_isempty(result)) then
      return vim.notify(("No " .. title .. " found"))
    else
      vim.fn.setqflist({}, " ", {title = title, items = util.locations_to_items(result, client.offset_encoding)})
      return vim.api.nvim_command("botright copen")
    end
  end
  return _2_
end
local function navigate(n)
  local handler0
  local function _4_(_, result, ctx, _0)
    if ((result == nil) or vim.tbl_isempty(result)) then
      return vim.notify(("No " .. n .. " found"))
    else
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if vim.tbl_islist(result) then
        util.jump_to_location(result[1], client.offset_encoding)
        return vim.cmd("norm zz")
      else
        return util.jump_to_location(result, client.offset_encoding)
      end
    end
  end
  handler0 = _4_
  local params
  do
    local param = util.make_position_params()
    param["direction"] = n
    params = param
  end
  return vim.lsp.buf_request(0, "$ccls/navigate", params, handler0)
end
local function ccls_info()
  local handler0
  local function _7_(_, result, _0, _1)
    return vim.print(result)
  end
  handler0 = _7_
  return vim.lsp.buf_request(0, "$ccls/info", nil, handler0)
end
local function ccls_fileInfo()
  local handler0
  local function _8_(err, result, _, _0)
    vim.print(err)
    return vim.print(result)
  end
  handler0 = _8_
  local params
  do
    local param = util.make_text_document_params(0)
    param["dependencies"] = true
    param["includes"] = true
    param["skipped_ranges"] = true
    params = param
  end
  vim.print(params)
  return vim.lsp.buf_request(0, "$ccls/fileInfo", params, handler0)
end
local function call(title)
  local handler0 = handler(title)
  local params
  do
    local param = util.make_position_params()
    local _9_
    if (title == "caller") then
      _9_ = false
    elseif (title == "callee") then
      _9_ = true
    else
      _9_ = nil
    end
    param["callee"] = _9_
    params = param
  end
  print(title)
  return vim.lsp.buf_request(0, "$ccls/call", params, handler0)
end
local function ccls_var(title)
  local handler0 = handler(title)
  local params
  do
    local param = util.make_position_params()
    local _13_
    if (title == "field") then
      _13_ = 1
    elseif (title == "local") then
      _13_ = 2
    elseif (title == "fieldOrLocal") then
      _13_ = 3
    elseif (title == "parameter") then
      _13_ = 4
    else
      _13_ = nil
    end
    param["kind"] = _13_
    params = param
  end
  print(title)
  return vim.lsp.buf_request(0, "$ccls/vars", params, handler0)
end
local function member(title)
  local handler0 = handler(("class " .. title))
  local params
  do
    local param = util.make_position_params()
    local _19_
    if (title == "variables") then
      _19_ = 4
    elseif (title == "functions") then
      _19_ = 3
    elseif (title == "types") then
      _19_ = 2
    else
      _19_ = nil
    end
    param["kind"] = _19_
    params = param
  end
  print(("Class " .. title))
  return vim.lsp.buf_request(0, "$ccls/member", params, handler0)
end
local function inheritance(title)
  local handler0 = handler(title)
  local params
  do
    local param = util.make_position_params()
    local _24_
    if (title == "base") then
      _24_ = false
    elseif (title == "derived") then
      _24_ = true
    else
      _24_ = nil
    end
    param["derived"] = _24_
    params = param
  end
  print(title)
  return vim.lsp.buf_request(0, "$ccls/inheritance", params, handler0)
end
local function extend_ref(role)
  local handler0 = handler(("Ref " .. role))
  local params
  do
    local param = util.make_position_params()
    local _28_
    if (role == "read") then
      _28_ = 8
    elseif (role == "write") then
      _28_ = 16
    elseif (role == "macro") then
      _28_ = 64
    else
      _28_ = nil
    end
    param["role"] = _28_
    param["excludeRole"] = 32
    params = param
  end
  print(("Ref " .. role))
  return vim.lsp.buf_request(0, "textDocument/references", params, handler0)
end
local semantic_hightlight_handler
local function _33_(err, result, ctx, config)
  local client = vim.lsp.get_clients({id = ctx.client_id})
  local symbols = result["symbols"]
  local uri = result["uri"]
  local bufnr = vim.uri_to_bufnr(uri)
  local ns = api.nvim_create_namespace("ccls-semantic-hightlights")
  local highlighter
  local function _34_(symbol, hl_group)
    for _, lsRange in ipairs(symbol.lsRanges) do
      api.nvim_buf_set_extmark(bufnr, ns, lsRange.start.line, lsRange.start.character, {end_row = lsRange["end"].line, end_col = lsRange["end"].character, hl_group = hl_group, priority = 125, strict = false})
    end
    return nil
  end
  highlighter = _34_
  if client then
    api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    for _, symbol in ipairs(symbols) do
      local and_35_ = (symbol == symbol)
      if and_35_ then
        and_35_ = (symbol.kind == 3)
      end
      if and_35_ then
        highlighter(symbol, "LspCxxHlGroupNamespace")
      else
        local and_37_ = (symbol == symbol)
        if and_37_ then
          and_37_ = (symbol.kind == 6)
        end
        if and_37_ then
          highlighter(symbol, "LspCxxHlSymMethod")
        else
          local and_39_ = (symbol == symbol)
          if and_39_ then
            and_39_ = (symbol.kind == 9)
          end
          if and_39_ then
            highlighter(symbol, "LspCxxHlSymConstructor")
          else
            local and_41_ = (symbol == symbol)
            if and_41_ then
              and_41_ = (symbol.kind == 12)
            end
            if and_41_ then
              highlighter(symbol, "LspCxxHlSymFunction")
            else
              local and_43_ = (symbol == symbol)
              if and_43_ then
                and_43_ = (symbol.kind == 254)
              end
              if and_43_ then
                highlighter(symbol, "LspCxxHlSymStaticMethod")
              else
                local and_45_ = (symbol == symbol)
                if and_45_ then
                  and_45_ = (symbol.kind == 13)
                end
                if and_45_ then
                  highlighter(symbol, "LspCxxHlSymVariable")
                else
                  local and_47_ = (symbol == symbol)
                  if and_47_ then
                    and_47_ = (symbol.kind == 253)
                  end
                  if and_47_ then
                    highlighter(symbol, "LspCxxHlSymParameter")
                  else
                    local and_49_ = (symbol == symbol)
                    if and_49_ then
                      and_49_ = ((symbol.kind == 5) or (symbol.kind == 23))
                    end
                    if and_49_ then
                      highlighter(symbol, "LspCxxHlSymStruct")
                    else
                      local and_51_ = (symbol == symbol)
                      if and_51_ then
                        and_51_ = (symbol.kind == 10)
                      end
                      if and_51_ then
                        highlighter(symbol, "LspCxxHlSymEnum")
                      else
                        local and_53_ = (symbol == symbol)
                        if and_53_ then
                          and_53_ = (symbol.kind == 252)
                        end
                        if and_53_ then
                          highlighter(symbol, "LspCxxHlSymTypeAlias")
                        else
                          local and_55_ = (symbol == symbol)
                          if and_55_ then
                            and_55_ = (symbol.kind == 26)
                          end
                          if and_55_ then
                            highlighter(symbol, "LspCxxHlSymTypeParameter")
                          else
                            local and_57_ = (symbol == symbol)
                            if and_57_ then
                              and_57_ = (symbol.kind == 8)
                            end
                            if and_57_ then
                              highlighter(symbol, "LspCxxHlSymField")
                            else
                              local and_59_ = (symbol == symbol)
                              if and_59_ then
                                and_59_ = (symbol.kind == 22)
                              end
                              if and_59_ then
                                highlighter(symbol, "LspCxxHlSymEnumMember")
                              else
                                local and_61_ = (symbol == symbol)
                                if and_61_ then
                                  and_61_ = (symbol.kind == 255)
                                end
                                if and_61_ then
                                  highlighter(symbol, "LspCxxHlSymMacro")
                                else
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    return nil
  else
    return nil
  end
end
semantic_hightlight_handler = _33_
local skipped_ranges_handler
local function _65_(err, result, ctx, config)
  local client = vim.lsp.get_clients({id = ctx.client_id})
  local ns = api.nvim_create_namespace("lsp-skipped-ranges-handler")
  if (client and result) then
    local and_66_ = ((_G.type(result) == "table") and (nil ~= result.skippedRanges) and (nil ~= result.uri))
    if and_66_ then
      local skippedRanges = result.skippedRanges
      local uri = result.uri
      and_66_ = (#skippedRanges == 0)
    end
    if and_66_ then
      local skippedRanges = result.skippedRanges
      local uri = result.uri
      return api.nvim_buf_clear_namespace(vim.uri_to_bufnr(uri), ns, 0, -1)
    elseif ((_G.type(result) == "table") and (nil ~= result.skippedRanges) and (nil ~= result.uri)) then
      local skippedRanges = result.skippedRanges
      local uri = result.uri
      for _, lsRange in ipairs(skippedRanges) do
        api.nvim_buf_set_extmark(vim.uri_to_bufnr(uri), ns, lsRange.start.line, lsRange.start.character, {end_row = lsRange["end"].line, end_col = lsRange["end"].character, hl_group = "Comment", priority = 126})
      end
      return nil
    else
      return nil
    end
  else
    return nil
  end
end
skipped_ranges_handler = _65_
return {navigate = navigate, ccls_info = ccls_info, ccls_fileInfo = ccls_fileInfo, call = call, ccls_var = ccls_var, member = member, inheritance = inheritance, extend_ref = extend_ref, ["semantic-hightlight-handler"] = semantic_hightlight_handler, ["skipped-ranges-handler"] = skipped_ranges_handler}
