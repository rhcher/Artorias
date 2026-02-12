-- [nfnl] fnl/plugins/ai.fnl
local function _1_()
  return require("sidekick.cli").toggle()
end
local function _2_()
  return require("sidekick.cli").select({filter = {installed = true}})
end
local function _3_()
  return require("sidekick.cli").send({msg = "{this}"})
end
local function _4_()
  return require("sidekick.cli").send({msg = "{selection}"})
end
local function _5_()
  return require("sidekick.cli").prompt()
end
local function _6_()
  return require("sidekick.cli").focus()
end
return {"folke/sidekick.nvim", keys = {{"<leader>aa", _1_, desc = "Sidekick Toggle CLI"}, {"<leader>as", _2_, desc = "Sidekick Select CLI"}, {"<leader>at", _3_, desc = "Send this", mode = {"x", "n"}}, {"<leader>av", _4_, desc = "Send Visual Selection", mode = {"x"}}, {"<leader>ap", _5_, desc = "Sidekick Select Prompt", mode = {"n", "x"}}, {"<c-.>", _6_, desc = "Sidekick Switch Focus", mode = {"n", "x", "i", "t"}}}, opts = {cli = {mux = {backend = "zellij", enabled = false}}}}
