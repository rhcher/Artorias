-- [nfnl] Compiled from fnl/dotfiles/plugin/lspconfig.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local cmplsp = autoload("cmp_nvim_lsp")
local protocol = autoload("vim.lsp.protocol")
local a = autoload("nfnl.core")
local function _2_(args)
  local bufnr = args.buf
  local ms = protocol.Methods
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if (client.supports_method(ms.textDocument_formatting) and client.supports_method(ms.textDocument_rangeFormatting)) then
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
        for k_2_auto, v_3_auto in pairs((nil or {})) do
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
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "<leader>lw", vim.lsp.buf.document_symbol, opts_1_auto)
  else
  end
  if client.supports_method(ms.workspace_symbol) then
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
        for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local ok, err = pcall(vim.lsp.inlay_hint, bufnr, true)
    if not ok then
      vim.print(err)
    else
    end
  else
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _46_()
      return vim.lsp.buf.references({includeDeclaration = false})
    end
    vim.keymap.set("n", "gr", _46_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _50_()
      local ufo = require("ufo")
      local lspsaga_hover = require("lspsaga.hover")
      local winid = ufo.peekFoldedLinesUnderCursor()
      if not winid then
        return vim.lsp.buf.hover()
      else
        return nil
      end
    end
    vim.keymap.set("n", "K", _50_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
  local function _58_()
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
  delete_empty_lsp_clients = _58_
  local group = vim.api.nvim_create_augroup("LspTimeOut", {clear = true})
  local function _60_()
    return vim.defer_fn(delete_empty_lsp_clients, 5000)
  end
  vim.api.nvim_create_autocmd({"BufDelete"}, {pattern = "*", callback = _60_, group = group})
  return nil
end
vim.api.nvim_create_autocmd("LspAttach", {callback = _2_})
do end (vim.lsp.handlers)["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single", title = "hover", title_pos = "left"})
local ccls_config = {capabilities = {foldingRangeProvider = true, workspace = {workspaceFolders = {supported = false}}}, index = {threads = a.count(vim.loop.cpu_info()), initialNoLinkage = true, initialBlacklist = {"/(clang|lld|llvm)/(test|unittests)/", "/llvm/(bindings|examples|utils)/", "/StaticAnalyzer/"}}, diagnostics = {onChange = -1, onOpen = 1000, onSave = 50}, highlight = {lsRanges = true}, cache = {directory = "/tmp/ccls-cache/"}, xref = {maxNum = 20000}}
local function ccls_on_attach(_, _0)
  local ccls = require("dotfiles.ccls")
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _64_()
      return ccls.navigate("L")
    end
    vim.keymap.set("n", "<C-k>", _64_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _68_()
      return ccls.navigate("R")
    end
    vim.keymap.set("n", "<C-j>", _68_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _72_()
      return ccls.navigate("D")
    end
    vim.keymap.set("n", "<C-l>", _72_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _76_()
      return ccls.navigate("U")
    end
    vim.keymap.set("n", "<C-h>", _76_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _80_()
      return ccls.call("caller")
    end
    vim.keymap.set("n", "<space>ii", _80_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _84_()
      return ccls.call("callee")
    end
    vim.keymap.set("n", "<space>io", _84_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _88_()
      return ccls.ccls_var("field")
    end
    vim.keymap.set("n", "<space>vf", _88_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _92_()
      return ccls.ccls_var("local")
    end
    vim.keymap.set("n", "<space>vl", _92_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _96_()
      return ccls.ccls_var("parameter")
    end
    vim.keymap.set("n", "<space>vp", _96_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _100_()
      return ccls.member("variables")
    end
    vim.keymap.set("n", "<space>mv", _100_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _104_()
      return ccls.member("functions")
    end
    vim.keymap.set("n", "<space>mf", _104_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _108_()
      return ccls.member("types")
    end
    vim.keymap.set("n", "<space>mt", _108_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _112_()
      return ccls.inheritance("base")
    end
    vim.keymap.set("n", "<space>ib", _112_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _116_()
      return ccls.inheritance("derived")
    end
    vim.keymap.set("n", "<space>id", _116_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _120_()
      return ccls.extend_ref("write")
    end
    vim.keymap.set("n", "<space>gw", _120_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _124_()
      return ccls.extend_ref("read")
    end
    vim.keymap.set("n", "<space>gr", _124_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _128_()
      return ccls.extend_ref("macro")
    end
    vim.keymap.set("n", "<space>gm", _128_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _132_()
      return ccls.extend_ref("notcall")
    end
    vim.keymap.set("n", "<space>gn", _132_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_14_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _136_()
      return ccls.ccls_fileInfo()
    end
    vim.keymap.set("n", "<space>cf", _136_, opts_1_auto)
  end
  local opts_1_auto
  do
    local tbl_14_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
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
  local function _140_()
    return ccls.ccls_info()
  end
  return vim.keymap.set("n", "<space>ci", _140_, opts_1_auto)
end
local sumneko_lua_config = {Lua = {diagnostics = {enable = true, globals = {"vim"}}, completion = {callSnippet = "Replace", showWord = "Disable"}, hint = {enable = true}, runtime = {version = "LuaJIT"}, workspace = {checkThirdParty = false}, IntelliSense = {traceLocalSet = true, traceReturn = true, traceBeSetted = true, traceFieldInject = true}, format = {enable = true, defaultConfig = {indent_style = "space", indent_size = "2"}}}}
local pylsp_config = {pylsp = {plugins = {pylint = {executable = "pylint", enabled = false}, pyflakes = {enabled = false}, pycodestyle = {enabled = false}, jedi_completion = {enabled = true, include_class_objects = true, eager = true, include_params = false, fuzzy = false}, pyls_isort = {enabled = true}, pylsp_mypy = {enabled = true}}}}
local pyright_config = {python = {analysis = {autoSearchPaths = true, useLibraryCodeForTypes = true, diagnositcMode = "workspace"}}}
local hls_config = {haskell = {formattingProvider = "ormolu"}}
local vimls_config = {diagnositc = {enable = true}, indexes = {count = 3, gap = 100, projectRootPatterns = {"runtime", "nvim", ".git", "autoload", "plugin"}, runtimepath = true}, isNeovim = true, isKeyword = "@,48-57,_,192-255,-#", runtimepath = "", suggest = {fromRuntimepath = true, fromVimruntime = true}, vimruntime = ""}
local ok_3f, lsp = pcall(require, "lspconfig")
local flags = {debounce_text_changes = 50}
local capabilities = cmplsp.default_capabilities()
capabilities.textDocument.foldingRange = {lineFoldingOnly = true, dynamicRegistration = false}
capabilities["workspace"] = {didChangeWatchedFiles = {dynamicRegistration = false}}
if ok_3f then
  lsp.ccls.setup({on_attach = ccls_on_attach, capabilities = capabilities, init_options = ccls_config, flags = flags})
  lsp.lua_ls.setup({capabilities = capabilities, cmd = {"/home/rhcher/sources/lua-language-server/bin/lua-language-server"}, settings = sumneko_lua_config, flags = flags})
  lsp.ocamllsp.setup({capabilities = capabilities, flags = flags})
  lsp.vimls.setup({capabilities = capabilities, flags = flags})
  lsp.hls.setup({capabilities = capabilities, settings = hls_config, flags = flags})
  lsp.racket_langserver.setup({capabilities = capabilities, flags = flags})
  return lsp.pyright.setup({capabilities = capabilities, settings = pyright_config, flags = flags})
else
  return nil
end
