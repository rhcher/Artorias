(let [(_ dashboard) (pcall require "dashboard")]
  (dashboard.setup
    {:config {:shortcut [{:desc " Sync" :group "@property" :action "Lazy sync" :key "s"}
                         {:desc " Files" :group "Label" :action "FzfLua files" :key "f"}]
              :project {:action "FzfLua files cwd="}}}))
