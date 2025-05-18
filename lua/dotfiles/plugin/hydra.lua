-- [nfnl] fnl/dotfiles/plugin/hydra.fnl
local _, hydra = pcall(require, "hydra")
hydra({name = "Side scroll", mode = "n", body = "z", heads = {{"h", "5zh"}, {"l", "5zl", {desc = "\226\134\144/\226\134\146"}}, {"H", "zH"}, {"L", "zL", {desc = "half screen \226\134\144/\226\134\146"}}}})
local _0, splits = pcall(require, "smart-splits")
return hydra({name = "smooth scroll", mode = "n", body = "<C-w>", heads = {{"<", splits.resize_left}, {">", splits.resize_right}, {"+", splits.resize_up}, {"-", splits.resize_down}}})
