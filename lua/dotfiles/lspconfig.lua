-- [nfnl] Compiled from fnl/dotfiles/lspconfig.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local protocol = autoload("vim.lsp.protocol")
local function _2_(args)
  local bufnr = args.buf
  local ms = protocol.Methods
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if (client.supports_method(ms.textDocument_formatting) and client.supports_method(ms.textDocument_rangeFormatting)) then
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
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
  if client.supports_method(ms.textDocument_prepareCallHierarchy) then
    do
      local opts_1_auto
      do
        local tbl_14_auto = {}
        for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
          local k_15_auto, v_16_auto = k_2_auto, v_3_auto
          if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
            tbl_14_auto[k_15_auto] = v_16_auto
          else
          end
        end
        opts_1_auto = tbl_14_auto
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
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
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
  if client.supports_method(ms.textDocument_documentSymbol) then
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
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
  if client.supports_method(ms.workspace_symbol) then
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
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
  if client.supports_method(ms.textDocument_codeAction) then
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    vim.keymap.set({"n", "v"}, "<leader>la", "<cmd>Lspsaga code_action<CR>", opts_1_auto)
  else
  end
  if client.supports_method(ms.textDocument_codeLens) then
    vim.api.nvim_create_autocmd({"BufEnter", "CursorHold", "InsertLeave"}, {buffer = bufnr, callback = vim.lsp.codelens.refresh})
    if client.supports_method(ms.workspace_executeCommand) then
      local opts_1_auto
      do
        local tbl_14_auto = {}
        for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
          local k_15_auto, v_16_auto = k_2_auto, v_3_auto
          if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
            tbl_14_auto[k_15_auto] = v_16_auto
          else
          end
        end
        opts_1_auto = tbl_14_auto
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
  if client.supports_method(ms.textDocument_inlayHint) then
    vim.lsp.inlay_hint(bufnr, true)
    local group = vim.api.nvim_create_augroup("my_inlayHint", {clear = true})
    local function _32_()
      local function _33_()
        return vim.lsp.inlay_hint(bufnr, true)
      end
      return vim.defer_fn(_33_, 1000)
    end
    vim.api.nvim_create_autocmd({"InsertLeave"}, {buffer = bufnr, callback = _32_, group = group})
    local function _34_()
      return vim.lsp.inlay_hint(bufnr, false)
    end
    vim.api.nvim_create_autocmd({"InsertEnter"}, {buffer = bufnr, callback = _34_, group = group})
  else
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
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
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
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
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
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
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _48_()
      return vim.lsp.buf.references({includeDeclaration = false})
    end
    vim.keymap.set("n", "gr", _48_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _52_()
      local _, ufo = pcall(require, "ufo")
      local _0, lspsaga_hover = pcall(require, "lspsaga.hover")
      local winid = ufo.peekFoldedLinesUnderCursor()
      if not winid then
        return lspsaga_hover:render_hover_doc({})
      else
        return nil
      end
    end
    vim.keymap.set("n", "K", _52_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
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
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_15_auto, v_16_auto = k_2_auto, v_3_auto
        if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
          tbl_14_auto[k_15_auto] = v_16_auto
        else
        end
      end
      opts_1_auto = tbl_14_auto
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
  local function _60_()
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
  delete_empty_lsp_clients = _60_
  local group = vim.api.nvim_create_augroup("LspTimeOut", {clear = true})
  local function _62_()
    return vim.defer_fn(delete_empty_lsp_clients, 5000)
  end
  vim.api.nvim_create_autocmd({"BufDelete"}, {pattern = "*", callback = _62_, group = group})
  return nil
end
vim.api.nvim_create_autocmd("LspAttach", {callback = _2_})
do end (vim.lsp.handlers)["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single", title = "hover", title_pos = "left"})
return nil
