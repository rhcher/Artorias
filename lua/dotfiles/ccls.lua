-- [nfnl] Compiled from fnl/dotfiles/ccls.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("vim.lsp.util")
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
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if client then
    do
      local _let_39_ = result
      local symbols = _let_39_["symbols"]
      local uri = _let_39_["uri"]
      for _, symbol in ipairs(symbols) do
        local _let_40_ = symbol
        local id = _let_40_["id"]
        local kind = _let_40_["kind"]
        local lsRanges = _let_40_["lsRanges"]
        local parentKind = _let_40_["parentKind"]
        local ranges = _let_40_["ranges"]
        local storage = _let_40_["storage"]
        for _0, lsRange in ipairs(lsRanges) do
          local _let_41_ = lsRange
          local _end = _let_41_["end"]
          local start = _let_41_["start"]
          local _let_42_ = _end
          local character_end = _let_42_["character"]
          local line_end = _let_42_["line"]
          local _let_43_ = start
          local character_start = _let_43_["character"]
          local line_start = _let_43_["line"]
          print("end: {", character_end, line_end, "}\n")
          print("start: {", character_start, line_start, "}")
        end
      end
      print("hell")
    end
    print("hello")
    return print("hello")
  else
    return nil
  end
end
semantic_hightlight_handler = _38_
local skipped_ranges_handler
local function _45_(err, result, ctx, config)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local ns = vim.api.nvim_create_namespace("lsp-skipped-ranges-handler")
  if (client and result) then
    local _46_ = result
    local function _47_()
      local skippedRanges = (_46_).skippedRanges
      local uri = (_46_).uri
      return (#skippedRanges == 0)
    end
    if (((_G.type(_46_) == "table") and (nil ~= (_46_).skippedRanges) and (nil ~= (_46_).uri)) and _47_()) then
      local skippedRanges = (_46_).skippedRanges
      local uri = (_46_).uri
      return vim.api.nvim_buf_clear_namespace(vim.api.nvim_get_current_buf(), ns, 0, -1)
    elseif ((_G.type(_46_) == "table") and (nil ~= (_46_).skippedRanges) and (nil ~= (_46_).uri)) then
      local skippedRanges = (_46_).skippedRanges
      local uri = (_46_).uri
      for _, lsRange in ipairs(skippedRanges) do
        vim.api.nvim_buf_set_extmark(vim.api.nvim_get_current_buf(), ns, lsRange.start.line, lsRange.start.character, {end_row = lsRange["end"].line, end_col = lsRange["end"].character, hl_group = "Comment", priority = 150})
      end
      return nil
    else
      return nil
    end
  else
    return nil
  end
end
skipped_ranges_handler = _45_
return nil
