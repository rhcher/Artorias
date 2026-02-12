-- [nfnl] fnl/config/fennel_indent.fnl
local delimiters = {[")"] = "(", ["]"] = "[", ["}"] = "{"}
local specials = {let = true, fn = true, lambda = true, ["\206\187"] = true, when = true, ["eval-compiler"] = true, ["for"] = true, each = true, ["while"] = true, ["import-macros"] = true, ["local"] = true, case = true, macro = true, match = true, doto = true, ["with-open"] = true, collect = true, icollect = true, accumulate = true}
local function symbol_at(line, pos)
  return line:sub(pos):match("[^%s]+")
end
local function find_string_start(line, end_quote_pos)
  local quote_pos = nil
  local state = "in-string"
  for pos = (end_quote_pos - 1), 1, -1 do
    if (state == "end") then break end
    local case_1_, case_2_ = line:sub(pos, pos), state
    if ((case_1_ == "\"") and true) then
      local _ = case_2_
      quote_pos = (pos - 1)
      state = "maybe-quote"
    elseif ((case_1_ == "\\") and (case_2_ == "maybe-quote")) then
      state = "escaped-quote"
    elseif ((case_1_ == "\\") and (case_2_ == "escaped-quote")) then
      state = "maybe-quote"
    elseif (true and (case_2_ == "maybe-quote")) then
      local _ = case_1_
      state = "end"
    else
      local _ = case_1_
      state = "in-string"
    end
  end
  return quote_pos
end
local function line_indent_type(stack, line, pos)
  local c = line:sub(pos, pos)
  local delimiter = stack[#stack]
  if (pos == 0) then
    return nil
  elseif (c == "\"") then
    local string_start = find_string_start(line, pos)
    if string_start then
      return line_indent_type(stack, line, string_start)
    else
      return nil
    end
  elseif (c == delimiter) then
    table.remove(stack)
    return line_indent_type(stack, line, (pos - 1))
  elseif delimiters[c] then
    table.insert(stack, delimiters[c])
    return line_indent_type(stack, line, (pos - 1))
  elseif delimiter then
    return line_indent_type(stack, line, (pos - 1))
  elseif ((c == "[") or (c == "{")) then
    return "table", pos
  elseif (c == "(") then
    return "call", pos, symbol_at(line, (pos + 1))
  else
    return line_indent_type(stack, line, (pos - 1))
  end
end
local function find_comment_start(line)
  local semicolon_pos = nil
  local state = "normal"
  for pos = 1, #line do
    if semicolon_pos then break end
    local case_6_, case_7_ = line:sub(pos, pos), state
    if ((case_6_ == ";") and (case_7_ == "normal")) then
      semicolon_pos = (pos - 1)
    elseif (true and (case_7_ == "escaping")) then
      local _ = case_6_
      state = "in-string"
    elseif ((case_6_ == "\\") and (case_7_ == "in-string")) then
      state = "escaping"
    elseif ((case_6_ == "\"") and (case_7_ == "in-string")) then
      state = "normal"
    elseif ((case_6_ == "\"") and (case_7_ == "normal")) then
      state = "in-string"
    else
    end
  end
  return semicolon_pos
end
local function indent_type(stack, lines, line_num)
  local line = lines[line_num]
  local line_length = (find_comment_start(line) or #line)
  local case_9_, case_10_, case_11_ = line_indent_type(stack, line, line_length)
  if ((case_9_ == "table") and (nil ~= case_10_)) then
    local pos = case_10_
    return "table", pos
  elseif ((case_9_ == "call") and (nil ~= case_10_) and (nil ~= case_11_)) then
    local pos = case_10_
    local fn_name = case_11_
    if specials[fn_name] then
      return "special", (pos - 1)
    elseif ((#line - pos) == #fn_name) then
      return "special", (pos - 1)
    else
      return "call", (pos - 1), fn_name
    end
  else
    local and_13_ = true
    if and_13_ then
      local _ = case_9_
      and_13_ = (line_num > 1)
    end
    if and_13_ then
      local _ = case_9_
      return indent_type(stack, lines, (line_num - 1))
    else
      return nil
    end
  end
end
local function fennel_indentexpr(line_num)
  local lines = vim.api.nvim_buf_get_lines(0, 0, line_num, true)
  if (line_num == 1) then
    return 0
  else
    local case_16_, case_17_, case_18_ = indent_type({}, lines, (line_num - 1))
    if ((case_16_ == "table") and (nil ~= case_17_)) then
      local delimiter_pos = case_17_
      return delimiter_pos
    elseif ((case_16_ == "special") and (nil ~= case_17_)) then
      local prev_indent = case_17_
      return (prev_indent + 2)
    elseif ((case_16_ == "call") and (nil ~= case_17_) and (nil ~= case_18_)) then
      local prev_indent = case_17_
      local fn_name = case_18_
      return (prev_indent + #fn_name + 2)
    else
      local _ = case_16_
      return 0
    end
  end
end
local function fennel_local()
  vim.opt_local.iskeyword = {"33-255", "^(", "^)", "^{", "^}", "^[", "^]", "^\"", "^'", "^~", "^;", "^,", "^@-@", "^`", "^:"}
  vim.opt_local.indentexpr = "v:lua.require(\"dotfiles.indentation\").fennel_indentexpr(v:lnum)"
  return nil
end
local function _21_()
  return fennel_local()
end
vim.api.nvim_create_autocmd({"FileType"}, {pattern = "fennel", callback = _21_})
return {indent_type = indent_type, fennel_indentexpr = fennel_indentexpr}
