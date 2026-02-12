(import-macros {: map} :dotfiles.macros)

(local find_next_start (fn [str cur-idx]
                         (while (and (<= cur-idx (length str))
                                     (= (str:sub cur-idx cur-idx) " "))
                           (set-forcibly! cur-idx (+ cur-idx 1)))
                         cur-idx))
(local str2argtable (fn [str]
                      (set-forcibly! str (string.gsub str "^%s*(.-)%s*$" "%1"))
                      (local arg-list {})
                      (var start 1)
                      (var i 1)
                      (var quote-refs-cnt 0)
                      (while (<= i (length str))
                        (local c (str:sub i i))
                        (if (= c "\"")
                            (do
                              (set quote-refs-cnt (+ quote-refs-cnt 1))
                              (set start i)
                              (set i (+ i 1))
                              (while (and (<= i (length str))
                                          (not= (str:sub i i) "\""))
                                (set i (+ i 1)))
                              (when (<= i (length str))
                                (set quote-refs-cnt (- quote-refs-cnt 1))
                                (tset arg-list (+ (length arg-list) 1)
                                      (str:sub start i))
                                (set start (find_next_start str (+ i 1)))
                                (set i start)))
                            (= c " ")
                            (do
                              (tset arg-list (+ (length arg-list) 1)
                                    (str:sub start (- i 1)))
                              (set start (find_next_start str (+ i 1)))
                              (set i start))
                            (set i (+ i 1))))
                      (when (and (not= start i) (= quote-refs-cnt 0))
                        (tset arg-list (+ (length arg-list) 1)
                              (str:sub start i)))
                      arg-list))


(let [dap (require "dap")
      dapui (require "dapui")]
  (set dap.adapters.cppdbg {:id "cppdbg"
                            :type "executable"
                            :command "/home/rhcher/source/dap/cpptools/extension/debugAdapters/bin/OpenDebugAD7"})
  (set dap.configurations.cpp [{:name "Launch file"
                                :type "cppdbg"
                                :request "launch"
                                :program #(vim.fn.input "Path to executable: "
                                                        (.. (vim.fn.getcwd) "/")
                                                        "file")
                                :args #(str2argtable (vim.fn.input "Argument input: "))
                                :cwd "${workspaceFolder}"
                                :stopAtEntry true
                                :setupCommands [{:text "-enable-pretty-printing"
                                                 :description "enable pretty printing"
                                                 :ignoreFailures false}]}
                               {:name "Attach process"
                                :type "cppdbg"
                                :request "attach"
                                :processId (. (require "dap.utils") "pick_process")
                                :cwd "${workspaceFolder}"
                                :program #(vim.fn.input "Path to executable"
                                                        (.. (vim.fn.getcwd) "/")
                                                        "file")}])
                                ; :useExtendedRemote true}])
  (set dap.configurations.c dap.configurations.cpp)
  (dapui.setup {})
  (tset dap.listeners.after.event_initialized
        :dapui_config #(dapui.open {}))
  (tset dap.listeners.before.event_terminated
        :dapui_config #(dapui.close {}))
  (tset dap.listeners.before.event_exited
        :dapui_config #(dapui.close {})))

(local dap-breakpoint
       {:error {:linehl ""
                :numhl ""
                :text "🛑"
                :texthl :LspDiagnosticsSignError}
        :rejected {:linehl ""
                   :numhl ""
                   :text ""
                   :texthl :LspDiagnosticsSignHint}
        :stopped {:linehl :DiagnosticUnderlineInfo
                  :numhl :LspDiagnosticsSignInformation
                  :text "⭐️"
                  :texthl :LspDiagnosticsSignInformation}})

(vim.fn.sign_define :DapBreakpoint dap-breakpoint.error)
(vim.fn.sign_define :DapStopped dap-breakpoint.stopped)
(vim.fn.sign_define :DapBreakpointRejected dap-breakpoint.rejected)  

(map [:n] "<F5>" #((. (require "dap") "continue")))
(map [:n] "<F10>" #((. (require "dap") "step_over")))
(map [:n] "<F11>" #((. (require "dap") "step_into")))
(map [:n] "<F12>" #((. (require "dap") "step_out")))
(map [:n] "<leader>db" #((. (require "dap") "toggle_breakpoint")))
(map [:n] "<leader>dB" #((. (require "dap") "set_breakpoint")))
(map [:n] "<leader>lp" #((. (require "dap") "set_breakpoint") nil nil (vim.fn.input "Log point message: ")))
(map [:n] "<leader>dr" #((. (. (require "dap") "repl") "open")))
(map [:n] "<leader>dl" #((. (require "dap") "run_last")))
(map [:n] "<leader>dt" #((. (require "dap") "terminate")))
(map [:n :v] "<leader>dh" #((. (require "dap.ui.widgets") "hover")))
(map [:n :v] "<leader>dp" #((. (require "dap.ui.widgets") "preview")))
(map [:n] "<leader>df" #(let [widgets (require "dap.ui.widgets")]
                          (widgets.centered_float widgets.frames)))
(map [:n] "<leader>ds" #(let [widgets (require "dap.ui.widgets")]
                          (widgets.centered_float widgets.scopes)))
