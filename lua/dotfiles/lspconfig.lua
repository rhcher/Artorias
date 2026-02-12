-- [nfnl] fnl/dotfiles/lspconfig.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local a = autoload("nfnl.core")
local protocol = autoload("vim.lsp.protocol")
local function _2_(args)
  local bufnr = args.buf
  local ms = protocol.Methods
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if (client:supports_method(ms.textDocument_formatting) and client:supports_method(ms.textDocument_rangeFormatting)) then
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _6_()
      return vim.lsp.buf.format({async = true})
    end
    vim.keymap.set({"n", "v"}, "<leader>lf", _6_, opts_1_auto)
  else
  end
  if client:supports_method(ms.textDocument_prepareCallHierarchy) then
    do
      local opts_1_auto
      do
        local tbl_21_ = {}
        for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
          local k_22_, v_23_ = k_2_auto, v_3_auto
          if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
            tbl_21_[k_22_] = v_23_
          else
          end
        end
        opts_1_auto = tbl_21_
      end
      if (opts_1_auto.noremap == nil) then
        opts_1_auto.noremap = true
      else
      end
      if (opts_1_auto.silent == nil) then
        opts_1_auto.silent = true
      else
      end
      vim.keymap.set("n", "<leader>ii", vim.lsp.buf.incoming_calls, opts_1_auto)
    end
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>io", vim.lsp.buf.outgoing_calls, opts_1_auto)
  else
  end
  if client:supports_method(ms.textDocument_documentSymbol) then
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>lw", "<cmd>Lspsaga outline<CR>", opts_1_auto)
  else
  end
  if client:supports_method(ms.workspace_symbol) then
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>lW", vim.lsp.buf.workspace_symbol, opts_1_auto)
  else
  end
  if client:supports_method(ms.textDocument_codeAction) then
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set({"n", "v"}, "<leader>la", vim.lsp.buf.code_action, opts_1_auto)
  else
  end
  if client:supports_method(ms.textDocument_codeLens) then
    local function _27_()
      return vim.lsp.codelens.refresh({bufnr = bufnr})
    end
    vim.api.nvim_create_autocmd({"BufEnter", "CursorHold", "InsertLeave"}, {buffer = bufnr, callback = _27_})
    if client:supports_method(ms.workspace_executeCommand) then
      local opts_1_auto
      do
        local tbl_21_ = {}
        for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
          local k_22_, v_23_ = k_2_auto, v_3_auto
          if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
            tbl_21_[k_22_] = v_23_
          else
          end
        end
        opts_1_auto = tbl_21_
      end
      if (opts_1_auto.noremap == nil) then
        opts_1_auto.noremap = true
      else
      end
      if (opts_1_auto.silent == nil) then
        opts_1_auto.silent = true
      else
      end
      vim.keymap.set("n", "<leader>ll", vim.lsp.codelens.run, opts_1_auto)
    else
    end
  else
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _45_()
      return vim.lsp.buf.references({includeDeclaration = false})
    end
    vim.keymap.set("n", "gr", _45_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _49_()
      local _, ufo = pcall(require, "ufo")
      local _0, lspsaga_hover = pcall(require, "lspsaga.hover")
      local winid = ufo.peekFoldedLinesUnderCursor()
      if not winid then
        return vim.lsp.buf.hover()
      else
        return nil
      end
    end
    vim.keymap.set("n", "K", _49_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc ++keep<CR>", opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set("n", "<leader>lr", ":Lspsaga rename<CR>", opts_1_auto)
  end
  local delete_empty_lsp_clients
  local function _57_()
    local clients = vim.lsp.get_clients()
    for _, client0 in ipairs(clients) do
      local bufs = vim.lsp.get_buffers_by_client_id(client0.id)
      if (#bufs == 0) then
        print(("stopping LSP server " .. client0.name))
        client0:stop()
      else
      end
    end
    return nil
  end
  delete_empty_lsp_clients = _57_
  local group = vim.api.nvim_create_augroup("LspTimeOut", {clear = true})
  local function _59_()
    return vim.defer_fn(delete_empty_lsp_clients, 5000)
  end
  vim.api.nvim_create_autocmd({"BufDelete"}, {pattern = "*", callback = _59_, group = group})
  return nil
end
vim.api.nvim_create_autocmd("LspAttach", {callback = _2_})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single", title = "hover", title_pos = "left"})
vim.lsp.config("*", {root_markers = {".git"}})
local function _60_(_, bufnr)
  local ccls = require("dotfiles.ccls")
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _64_()
      return ccls.navigate("L")
    end
    vim.keymap.set("n", "<C-k>", _64_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _68_()
      return ccls.navigate("R")
    end
    vim.keymap.set("n", "<C-j>", _68_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _72_()
      return ccls.navigate("D")
    end
    vim.keymap.set("n", "<C-l>", _72_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _76_()
      return ccls.navigate("U")
    end
    vim.keymap.set("n", "<C-h>", _76_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _80_()
      return ccls.call("caller")
    end
    vim.keymap.set("n", "<space>ii", _80_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _84_()
      return ccls.call("callee")
    end
    vim.keymap.set("n", "<space>io", _84_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _88_()
      return ccls.ccls_var("field")
    end
    vim.keymap.set("n", "<space>vf", _88_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _92_()
      return ccls.ccls_var("local")
    end
    vim.keymap.set("n", "<space>vl", _92_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _96_()
      return ccls.ccls_var("parameter")
    end
    vim.keymap.set("n", "<space>vp", _96_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _100_()
      return ccls.member("variables")
    end
    vim.keymap.set("n", "<space>mv", _100_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _104_()
      return ccls.member("functions")
    end
    vim.keymap.set("n", "<space>mf", _104_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _108_()
      return ccls.member("types")
    end
    vim.keymap.set("n", "<space>mt", _108_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _112_()
      return ccls.inheritance("base")
    end
    vim.keymap.set("n", "<space>ib", _112_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _116_()
      return ccls.inheritance("derived")
    end
    vim.keymap.set("n", "<space>id", _116_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _120_()
      return ccls.extend_ref("write")
    end
    vim.keymap.set("n", "<space>gw", _120_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _124_()
      return ccls.extend_ref("read")
    end
    vim.keymap.set("n", "<space>gr", _124_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _128_()
      return ccls.extend_ref("macro")
    end
    vim.keymap.set("n", "<space>gm", _128_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _132_()
      return ccls.extend_ref("notcall")
    end
    vim.keymap.set("n", "<space>gn", _132_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _136_()
      return ccls.ccls_fileInfo()
    end
    vim.keymap.set("n", "<space>cf", _136_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_22_, v_23_ = k_2_auto, v_3_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_1_auto = tbl_21_
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _140_()
      return ccls.ccls_info()
    end
    vim.keymap.set("n", "<space>ci", _140_, opts_1_auto)
  end
  vim.lsp.handlers["$ccls/publishSkippedRanges"] = ccls["skipped-ranges-handler"]
  vim.lsp.handlers["$ccls/publishSemanticHighlight"] = ccls["semantic-hightlight-handler"]
  return nil
end
vim.lsp.config("ccls", {cmd = {"ccls"}, filetypes = {"c", "cpp", "objc", "objcpp", "cuda"}, root_markers = {"compile_commands.json", ".ccls"}, offset_encoding = "utf-32", workspace_required = true, on_attach = _60_, init_options = {capabilities = {foldingRangeProvider = true}, workspace = {workspaceFolders = {supported = false}}, clang = {excludeArgs = {"-fconserve-stack", "-fno-allow-store-data-races", "-Wp", "-MMD", "-fomit-frame-pointer", "-Wmissing-prototypes", "-Wstrict-prototypes"}}, index = {threads = a.count(vim.loop.cpu_info()), initialNoLinkage = true, initialBlacklist = {"/(clang|lld|llvm)/(test|unittests)/", "/llvm/(bindings|examples|utils)/", "/StaticAnalyzer/"}}, diagnostics = {onChange = -1, onOpen = 1000, onSave = 50}, highlight = {lsRanges = true}, cache = {retainInMemory = 1, directory = "/tmp/ccls-cache/"}, xref = {maxNum = 20000}}})
local function _141_(client, config)
  return (client.name == config.name)
end
vim.lsp.config("clangd", {cmd = {"clangd", "--clang-tidy", "--background-index", "--completion-style=detailed", "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*", "--cross-file-rename", "--header-insertion=never"}, filetypes = {"c", "cpp", "objc", "objcpp", "cuda", "proto"}, root_markers = {"compile_commands.json", ".clangd", ".clang-format", "compile_flags.txt"}, capabilities = {textDocument = {completion = {editsNearCursor = true}}, offsetEncoding = {"utf-8", "utf-16"}}, reuse_client = _141_})
vim.lsp.config("lua_ls", {cmd = {"lua-language-server"}, filetypes = {"lua"}, root_markers = {".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml"}})
vim.lsp.config("emmylua_ls", {cmd = {"emmylua_ls"}, filetypes = {"lua"}, root_markers = {".luarc.json", ".emmyrc.json", ".luacheckrc", ".git"}, settings = {Lua = {workspace = {library = {vim.env.VIMRUNTIME}}}}})
vim.lsp.config("clice", {cmd = {"/home/rhcher/source/clice/clice", "--resource-dir=/usr/lib/clang/20/"}, filetypes = {"c", "cpp"}, root_markers = {"compile_commands.json", ".clang-format"}})
vim.lsp.config("basedpyright", {cmd = {"basedpyright-langserver", "--stdio"}, filetypes = {"python"}, root_markers = {"pyproject.toml", "setup.py", "requirements.txt"}, settings = {basedpyright = {analysis = {autoSearchPaths = true, useLibraryCodeForTypes = true, diagnosticMode = "openFilesOnly"}}}})
return vim.lsp.enable({"clangd", "emmylua_ls", "basedpyright"})
