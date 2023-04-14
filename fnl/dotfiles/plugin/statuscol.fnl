(module dotfiles.plugin.statuscol)

(when-let [(_ stc) (pcall require "statuscol")]
  (let [builtin (require "statuscol.builtin")]
    (stc.setup {:relculright true
                :segments [{:text ["%s"] :click "v:lua.ScSa"}
                           {:text [ builtin.lnumfunc ] :click "v:lua.ScLa"}
                           {:text [" " builtin.foldfunc " "] :click "v:lua.ScFa"}]})))
