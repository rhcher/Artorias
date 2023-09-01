(local hlslens (require "hlslens"))
(var config nil)
(var lens-bak nil)
(fn override-lens [render pos-list nearest idx rel-idx]
  (let [_ rel-idx
        (lnum col) (unpack (. pos-list idx))]
    (var (text chunks) nil)
    (if nearest
        (do
          (set text (: "[%d/%d]" :format idx (length pos-list)))
          (set chunks [[" " :Ignore] [text :VM_Extend]]))
        (do
          (set text (: "[%d]" :format idx))
          (set chunks [[" " :Ignore] [text :HlSearchLens]])))
    (render.setVirt 0 (- lnum 1) (- col 1) chunks nearest)))

(fn start []
  (when hlslens (set config (require :hlslens.config))
    (set lens-bak config.override_lens)
    (set config.override_lens override-lens)
    (hlslens.start)))

(fn exit []
  (when hlslens (set config.override_lens lens-bak) (hlslens.start)))

{: start
 : exit}
