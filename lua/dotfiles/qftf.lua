-- [nfnl] fnl/dotfiles/qftf.fnl
_G.qftf = function(info)
  local ret = {}
  local items
  if (info.quickfix == 1) then
    items = vim.fn.getqflist({id = info.id, items = 0}).items
  else
    items = vim.fn.getloclist(info.winid, {id = info.id, items = 0}).items
  end
  local limit = 31
  local fname_fmt1 = ("%-" .. limit .. "s")
  local fname_fmt2 = ("\226\128\166%." .. (limit - 1) .. "s")
  local valid_fmt = "%s \226\148\130%5d:%-3d\226\148\130%s %s"
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ""
    local str = ""
    if (e.valid == 1) then
      if (e.bufnr > 0) then
        fname = vim.fn.bufname(e.bufnr)
        if (fname == "") then
          fname = "[No Name]"
        else
          fname = fname:gsub(("^" .. vim.env.HOME), "~")
        end
        if (#fname <= limit) then
          fname = fname_fmt1:format(fname)
        else
          fname = fname_fmt2:format(fname:sub((1 - limit)))
        end
      else
      end
      local lnum
      if (e.lnum > 99999) then
        lnum = -1
      else
        lnum = e.lnum
      end
      local col
      if (e.col > 999) then
        col = -1
      else
        col = e.col
      end
      local qtype
      if (e.type == "") then
        qtype = ""
      else
        qtype = (" " .. e.type:sub(1, 1):upper())
      end
      str = valid_fmt:format(fname, lnum, col, qtype, e.text)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end
vim.o.qftf = "{info -> v:lua._G.qftf(info)}"
return nil
