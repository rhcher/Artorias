-- [nfnl] fnl/dotfiles/plugin/mini.fnl
local _, mini_file = pcall(require, "mini.files")
local _0, mini_icon = pcall(require, "mini.icons")
local _1, mini_sessions = pcall(require, "mini.sessions")
local _2, mini_ai = pcall(require, "mini.ai")
local _3, mini_extra = pcall(require, "mini.extra")
local gen_ai_spec = require("mini.extra").gen_ai_spec
mini_file.setup()
mini_icon.setup()
mini_sessions.setup()
mini_ai.setup()
mini_extra.setup()
return mini_ai.setup({custom_textobjects = {B = gen_ai_spec.buffer(), D = gen_ai_spec.diagnostic(), I = gen_ai_spec.indent(), L = gen_ai_spec.line(), N = gen_ai_spec.number()}})
