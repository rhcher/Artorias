(let [(_ mini_file) (pcall require "mini.files")
      (_ mini_icon) (pcall require "mini.icons")
      (_ mini_sessions) (pcall require "mini.sessions")
      (_ mini_snippet) (pcall require "mini.snippets")]
  (mini_file.setup)
  (mini_icon.setup)
  (mini_sessions.setup)
  (mini_snippet.setup))
