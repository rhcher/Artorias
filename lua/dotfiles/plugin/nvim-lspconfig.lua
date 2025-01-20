-- [nfnl] Compiled from fnl/dotfiles/plugin/nvim-lspconfig.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local protocol = autoload("vim.lsp.protocol")
local a = autoload("nfnl.core")
local ccls_config = {capabilities = {foldingRangeProvider = true, workspace = {workspaceFolders = {supported = false}}}, clang = {excludeArgs = {"-fconserve-stack", "-fno-allow-store-data-races", "-Wp", "-MMD", "-fomit-frame-pointer", "-Wmissing-prototypes", "-Wstrict-prototypes"}}, index = {threads = a.count(vim.loop.cpu_info()), initialNoLinkage = true, initialBlacklist = {"/(clang|lld|llvm)/(test|unittests)/", "/llvm/(bindings|examples|utils)/", "/StaticAnalyzer/"}}, diagnostics = {onChange = -1, onOpen = 1000, onSave = 50}, highlight = {lsRanges = true}, cache = {retainInMemory = 1, directory = "/tmp/ccls-cache/"}, xref = {maxNum = 20000}}
local function clangd_on_attach(_, bufnr)
  local myclangd = require("dotfiles.clangd")
  local opts_1_auto
  do
    local tbl_16_auto = {}
    for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
      local k_17_auto, v_18_auto = k_2_auto, v_3_auto
      if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
        tbl_16_auto[k_17_auto] = v_18_auto
      else
      end
    end
    opts_1_auto = tbl_16_auto
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _5_()
    return myclangd.ast()
  end
  return vim.keymap.set("n", "<leader>cc", _5_, opts_1_auto)
end
local function ccls_on_attach(_, bufnr)
  local ccls = require("dotfiles.ccls")
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _9_()
      return ccls.navigate("L")
    end
    vim.keymap.set("n", "<C-k>", _9_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _13_()
      return ccls.navigate("R")
    end
    vim.keymap.set("n", "<C-j>", _13_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _17_()
      return ccls.navigate("D")
    end
    vim.keymap.set("n", "<C-l>", _17_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _21_()
      return ccls.navigate("U")
    end
    vim.keymap.set("n", "<C-h>", _21_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _25_()
      return ccls.call("caller")
    end
    vim.keymap.set("n", "<space>ii", _25_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _29_()
      return ccls.call("callee")
    end
    vim.keymap.set("n", "<space>io", _29_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _33_()
      return ccls.ccls_var("field")
    end
    vim.keymap.set("n", "<space>vf", _33_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _37_()
      return ccls.ccls_var("local")
    end
    vim.keymap.set("n", "<space>vl", _37_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _41_()
      return ccls.ccls_var("parameter")
    end
    vim.keymap.set("n", "<space>vp", _41_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
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
      return ccls.member("variables")
    end
    vim.keymap.set("n", "<space>mv", _45_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
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
      return ccls.member("functions")
    end
    vim.keymap.set("n", "<space>mf", _49_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _53_()
      return ccls.member("types")
    end
    vim.keymap.set("n", "<space>mt", _53_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _57_()
      return ccls.inheritance("base")
    end
    vim.keymap.set("n", "<space>ib", _57_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _61_()
      return ccls.inheritance("derived")
    end
    vim.keymap.set("n", "<space>id", _61_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _65_()
      return ccls.extend_ref("write")
    end
    vim.keymap.set("n", "<space>gw", _65_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _69_()
      return ccls.extend_ref("read")
    end
    vim.keymap.set("n", "<space>gr", _69_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _73_()
      return ccls.extend_ref("macro")
    end
    vim.keymap.set("n", "<space>gm", _73_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _77_()
      return ccls.extend_ref("notcall")
    end
    vim.keymap.set("n", "<space>gn", _77_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _81_()
      return ccls.ccls_fileInfo()
    end
    vim.keymap.set("n", "<space>cf", _81_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({buffer = bufnr} or {})) do
        local k_17_auto, v_18_auto = k_2_auto, v_3_auto
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts_1_auto = tbl_16_auto
    end
    if (opts_1_auto.noremap == nil) then
      opts_1_auto.noremap = true
    else
    end
    if (opts_1_auto.silent == nil) then
      opts_1_auto.silent = true
    else
    end
    local function _85_()
      return ccls.ccls_info()
    end
    vim.keymap.set("n", "<space>ci", _85_, opts_1_auto)
  end
  vim.lsp.handlers["$ccls/publishSkippedRanges"] = ccls["skipped-ranges-handler"]
  vim.lsp.handlers["$ccls/publishSemanticHighlight"] = ccls["semantic-hightlight-handler"]
  return nil
end
local sumneko_lua_config = {Lua = {diagnostics = {enable = true, globals = {"vim"}}, completion = {callSnippet = "Replace", showWord = "Disable"}, hint = {enable = true}, runtime = {version = "LuaJIT"}, workspace = {library = {vim.env.VIMRUNTIME}, checkThirdParty = false}, IntelliSense = {traceLocalSet = true, traceReturn = true, traceBeSetted = true, traceFieldInject = true}, format = {enable = true, defaultConfig = {indent_style = "space", indent_size = "2"}}}}
local pylsp_config = {pylsp = {plugins = {pylint = {executable = "pylint", enabled = false}, pyflakes = {enabled = false}, pycodestyle = {enabled = false}, jedi_completion = {enabled = true, include_class_objects = true, eager = true, fuzzy = false, include_params = false}, pyls_isort = {enabled = true}, pylsp_mypy = {enabled = true}}}}
local pyright_config = {python = {analysis = {autoSearchPaths = true, useLibraryCodeForTypes = true, diagnositcMode = "workspace"}}}
local hls_config = {haskell = {formattingProvider = "ormolu"}}
local vimls_config = {diagnositc = {enable = true}, indexes = {count = 3, gap = 100, projectRootPatterns = {"runtime", "nvim", ".git", "autoload", "plugin"}, runtimepath = true}, isNeovim = true, isKeyword = "@,48-57,_,192-255,-#", runtimepath = "", suggest = {fromRuntimepath = true, fromVimruntime = true}, vimruntime = ""}
local ok_3f, lsp = pcall(require, "lspconfig")
local flags = {debounce_text_changes = 50}
local _, cmplsp = pcall(require, "cmp_nvim_lsp")
local capabilities = cmplsp.default_capabilities()
capabilities.textDocument.foldingRange = {lineFoldingOnly = true, dynamicRegistration = false}
if ok_3f then
  lsp.clangd.setup({on_attach = clangd_on_attach, capabilities = capabilities, cmd = {"clangd", "--clang-tidy", "--background-index", "--completion-style=detailed", "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*", "--cross-file-rename", "--header-insertion=never"}, flags = flags})
  lsp.lua_ls.setup({capabilities = capabilities, settings = sumneko_lua_config, flags = flags})
  lsp.ocamllsp.setup({capabilities = capabilities, flags = flags})
  lsp.vimls.setup({capabilities = capabilities, flags = flags})
  lsp.hls.setup({capabilities = capabilities, settings = hls_config, flags = flags})
  lsp.racket_langserver.setup({capabilities = capabilities, flags = flags})
  lsp.pyright.setup({capabilities = capabilities, settings = pyright_config, flags = flags})
  lsp.leanls.setup({capabilities = capabilities, flags = flags})
  return lsp.zls.setup({capabilities = capabilities, flags = flags})
else
  return nil
end
