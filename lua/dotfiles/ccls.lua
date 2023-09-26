-- [nfnl] Compiled from fnl/dotfiles/ccls.fnl by https://github.com/Olical/nfnl, do not edit.
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
    do end (param)["direction"] = n
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
    do end (param)["dependencies"] = true
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
    local _10_
    do
      local _9_ = title
      if (_9_ == "caller") then
        _10_ = false
      elseif (_9_ == "callee") then
        _10_ = true
      else
        _10_ = nil
      end
    end
    param["callee"] = _10_
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
    local _15_
    do
      local _14_ = title
      if (_14_ == "field") then
        _15_ = 1
      elseif (_14_ == "local") then
        _15_ = 2
      elseif (_14_ == "fieldOrLocal") then
        _15_ = 3
      elseif (_14_ == "parameter") then
        _15_ = 4
      else
        _15_ = nil
      end
    end
    param["kind"] = _15_
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
    local _22_
    do
      local _21_ = title
      if (_21_ == "variables") then
        _22_ = 4
      elseif (_21_ == "functions") then
        _22_ = 3
      elseif (_21_ == "types") then
        _22_ = 2
      else
        _22_ = nil
      end
    end
    param["kind"] = _22_
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
    local _28_
    do
      local _27_ = title
      if (_27_ == "base") then
        _28_ = false
      elseif (_27_ == "derived") then
        _28_ = true
      else
        _28_ = nil
      end
    end
    param["derived"] = _28_
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
    local _33_
    do
      local _32_ = role
      if (_32_ == "read") then
        _33_ = 8
      elseif (_32_ == "write") then
        _33_ = 16
      elseif (_32_ == "macro") then
        _33_ = 64
      else
        _33_ = nil
      end
    end
    param["role"] = _33_
    param["excludeRole"] = 32
    params = param
  end
  print(("Ref " .. role))
  return vim.lsp.buf_request(0, "textDocument/references", params, handler0)
end
local semantic_hightlight_handler
local function _38_(err, result, ctx, config)
  local client = vim.lsp.get_clients({id = ctx.client_id})
  local _let_39_ = result
  local symbols = _let_39_["symbols"]
  local uri = _let_39_["uri"]
  local bufnr = vim.uri_to_bufnr(uri)
  local ns = api.nvim_create_namespace("ccls-semantic-hightlights")
  local highlighter
  local function _40_(symbol, hl_group)
    for _, lsRange in ipairs(symbol.lsRanges) do
      api.nvim_buf_set_extmark(bufnr, ns, lsRange.start.line, lsRange.start.character, {end_row = lsRange["end"].line, end_col = lsRange["end"].character, hl_group = hl_group, priority = 125, strict = false})
    end
    return nil
  end
  highlighter = _40_
  if client then
    api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    for _, symbol in ipairs(symbols) do
      local _41_ = symbol
      local function _42_()
        return (symbol.kind == 3)
      end
      if ((_41_ == symbol) and _42_()) then
        highlighter(symbol, "LspCxxHlGroupNamespace")
      else
        local function _43_()
          return (symbol.kind == 6)
        end
        if ((_41_ == symbol) and _43_()) then
          highlighter(symbol, "LspCxxHlSymMethod")
        else
          local function _44_()
            return (symbol.kind == 9)
          end
          if ((_41_ == symbol) and _44_()) then
            highlighter(symbol, "LspCxxHlSymConstructor")
          else
            local function _45_()
              return (symbol.kind == 12)
            end
            if ((_41_ == symbol) and _45_()) then
              highlighter(symbol, "LspCxxHlSymFunction")
            else
              local function _46_()
                return (symbol.kind == 254)
              end
              if ((_41_ == symbol) and _46_()) then
                highlighter(symbol, "LspCxxHlSymStaticMethod")
              else
                local function _47_()
                  return (symbol.kind == 13)
                end
                if ((_41_ == symbol) and _47_()) then
                  highlighter(symbol, "LspCxxHlSymVariable")
                else
                  local function _48_()
                    return (symbol.kind == 253)
                  end
                  if ((_41_ == symbol) and _48_()) then
                    highlighter(symbol, "LspCxxHlSymParameter")
                  else
                    local function _49_()
                      return ((symbol.kind == 5) or (symbol.kind == 23))
                    end
                    if ((_41_ == symbol) and _49_()) then
                      highlighter(symbol, "LspCxxHlSymStruct")
                    else
                      local function _50_()
                        return (symbol.kind == 10)
                      end
                      if ((_41_ == symbol) and _50_()) then
                        highlighter(symbol, "LspCxxHlSymEnum")
                      else
                        local function _51_()
                          return (symbol.kind == 252)
                        end
                        if ((_41_ == symbol) and _51_()) then
                          highlighter(symbol, "LspCxxHlSymTypeAlias")
                        else
                          local function _52_()
                            return (symbol.kind == 26)
                          end
                          if ((_41_ == symbol) and _52_()) then
                            highlighter(symbol, "LspCxxHlSymTypeParameter")
                          else
                            local function _53_()
                              return (symbol.kind == 8)
                            end
                            if ((_41_ == symbol) and _53_()) then
                              highlighter(symbol, "LspCxxHlSymField")
                            else
                              local function _54_()
                                return (symbol.kind == 22)
                              end
                              if ((_41_ == symbol) and _54_()) then
                                highlighter(symbol, "LspCxxHlSymEnumMember")
                              else
                                local function _55_()
                                  return (symbol.kind == 255)
                                end
                                if ((_41_ == symbol) and _55_()) then
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
semantic_hightlight_handler = _38_
local skipped_ranges_handler
local function _58_(err, result, ctx, config)
  local client = vim.lsp.get_clients({id = ctx.client_id})
  local ns = api.nvim_create_namespace("lsp-skipped-ranges-handler")
  if (client and result) then
    local _59_ = result
    local function _60_()
      local skippedRanges = (_59_).skippedRanges
      local uri = (_59_).uri
      return (#skippedRanges == 0)
    end
    if (((_G.type(_59_) == "table") and (nil ~= (_59_).skippedRanges) and (nil ~= (_59_).uri)) and _60_()) then
      local skippedRanges = (_59_).skippedRanges
      local uri = (_59_).uri
      return api.nvim_buf_clear_namespace(vim.uri_to_bufnr(uri), ns, 0, -1)
    elseif ((_G.type(_59_) == "table") and (nil ~= (_59_).skippedRanges) and (nil ~= (_59_).uri)) then
      local skippedRanges = (_59_).skippedRanges
      local uri = (_59_).uri
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
skipped_ranges_handler = _58_
return {navigate = navigate, ccls_info = ccls_info, ccls_fileInfo = ccls_fileInfo, call = call, ccls_var = ccls_var, member = member, inheritance = inheritance, extend_ref = extend_ref, ["semantic-hightlight-handler"] = semantic_hightlight_handler, ["skipped-ranges-handler"] = skipped_ranges_handler}
