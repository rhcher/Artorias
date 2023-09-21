-- [nfnl] Compiled from fnl/dotfiles/plugin/auto-pairs.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("dotfiles.util")
local pair = require("ultimate-autopair")
return pair.setup({cr = {conf = {nft = util["lisp-language"]}}, bs = {map = {"<bs>", "<C-w>"}}, tabout = {enable = true, map = "<tab>", hopout = true, do_nothing_if_fail = false}})
