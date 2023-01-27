(module dotfiles.plugin.dashboard)

(when-let [(_ dashboard) (pcall require "dashboard")]
  (dashboard.setup
    {:config {:shortcut [{:desc " Update" :group "@property" :action "Lazy update" :key "u"}
                         {:desc " Files" :group "Label" :action "FzfLua files" :key "f"}]
              :project {:action "FzfLua files cwd="}}}))
