-- [nfnl] fnl/dotfiles/plugin/vmlens.fnl
local hlslens = require("hlslens")
local config = nil
local lens_bak = nil
local function override_lens(render, pos_list, nearest, idx, rel_idx)
  local _ = rel_idx
  local lnum, col = unpack(pos_list[idx])
  local text, chunks = nil
  if nearest then
    text = ("[%d/%d]"):format(idx, #pos_list)
    chunks = {{" ", "Ignore"}, {text, "VM_Extend"}}
  else
    text = ("[%d]"):format(idx)
    chunks = {{" ", "Ignore"}, {text, "HlSearchLens"}}
  end
  return render.setVirt(0, (lnum - 1), (col - 1), chunks, nearest)
end
local function start()
  if hlslens then
    config = require("hlslens.config")
    lens_bak = config.override_lens
    config.override_lens = override_lens
    return hlslens.start()
  else
    return nil
  end
end
local function exit()
  if hlslens then
    config.override_lens = lens_bak
    return hlslens.start()
  else
    return nil
  end
end
return {start = start, exit = exit}
