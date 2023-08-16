-- [nfnl] Compiled from fnl/dotfiles/util.fnl by https://github.com/Olical/nfnl, do not edit.
local lisp_language = {"fennel", "lisp", "scheme", "racket", "clojure", "janet", "timl"}
local function contain_3f(key, dict)
  local result = false
  for _, k in ipairs(dict) do
    if (k == key) then
      result = true
    else
    end
  end
  return result
end
return {["lisp-language"] = lisp_language, ["contain?"] = contain_3f, luamap = luamap}
