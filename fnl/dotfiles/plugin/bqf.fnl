(module dotfiles.plugin.bqf
  {autoload {bqf bqf}})

(bqf.setup {:preview {:auto_preview false}
            :auto_resize_height true})

(vim.api.nvim_create_autocmd [:FileType]
                             {:pattern [:qf :man :help :lspinfo]
                              :command "nnoremap <buffer><silent> q :close<CR>"})

; pretty quicklist copy from nvim-bqf
(defn _G.qftf [info]
  (let [ret {}
        items (if
                (= info.quickfix 1)
                (. (vim.fn.getqflist {:id info.id
                                      :items 0}) :items)
                (. (vim.fn.getloclist info.winid
                                      {:id info.id
                                       :items 0}) :items))
        limit 31
        fname_fmt1 (.. "%-" limit "s")
        fname_fmt2 (.. "…%." (- limit 1) "s")
        valid_fmt "%s │%5d:%-3d│%s %s"]
    (for [i info.start_idx info.end_idx]
      (let [e (. items i)]
        (var fname "")
        (var str "")
        (if 
          (= e.valid 1)
          (do
            (when (> e.bufnr 0)
              (set fname (vim.fn.bufname e.bufnr))
              (if 
                (= fname "")
                (set fname "[No Name]")
                (set fname (: fname :gsub (.. "^" vim.env.HOME) "~")))
              (if 
                (<= (length fname) limit)
                (set fname (: fname_fmt1 :format fname))
                (set fname (: fname_fmt2 :format (: fname :sub (- 1 limit))))))
            (let [lnum (if (> e.lnum 99999) -1 e.lnum)
                  col (if (> e.col 999) -1 e.col)
                  qtype (if (= e.type "") "" (.. " " (: (: e.type :sub 1 1) :upper)))]
              (set str (: valid_fmt :format fname lnum col qtype e.text))))
          (set str e.text))
        (table.insert ret str)))
    ret))

(set vim.o.qftf "{info -> v:lua._G.qftf(info)}")
