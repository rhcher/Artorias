(module dotfiles.util
  {autoload {nvim aniseed.nvim
             a aniseed.core}})

(def lisp-language [:fennel :lisp :scheme :racket :clojure :janet :timl])

(defn contain? [key dict]
  (var result false)
  (each [_ k (ipairs dict)]
    (if (= k key)
      (set result true)))
  result)

(defn expand [path]
  (nvim.fn.expand path))

(defn glob [path]
  (nvim.fn.glob path true true true))

(defn exists? [path]
  (= (nvim.fn.filereadable path) 1))

(defn lua-file [path]
  (nvim.ex.luafile path))

(def config-path (nvim.fn.stdpath "config"))

(defn nnoremap [from to opts]
  (let [map-opts {:noremap true}
        to (.. ":" to "<cr>")]
    (if (a.get opts :local?)
      (nvim.buf_set_keymap 0 :n from to map-opts)
      (nvim.set_keymap :n from to map-opts))))

(defn luamap [mode from to]
  (vim.keymap.set mode from to {:noremap true :silent true :buffer true}))
