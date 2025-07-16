-- [nfnl] fnl/dotfiles/util.fnl
local lisp_language = {"fennel", "lisp", "scheme", "racket", "clojure", "janet", "timl"}
local treesitter_language = {"c", "cpp", "rust", "lua", "python", "cmake", "markdown", "markdown_inline", "vim", "fennel", "query", "ocaml", "ocaml_interface", "haskell", "scheme", "regex", "bash", "luap", "racket", "html"}
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
return {["lisp-language"] = lisp_language, ["treesitter-language"] = treesitter_language, ["contain?"] = contain_3f}
