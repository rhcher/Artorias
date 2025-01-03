-- [nfnl] Compiled from fnl/dotfiles/plugin.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local lazy = autoload("lazy")
local a = autoload("nfnl.core")
local util = autoload("dotfiles.util")
local lazy_config = {defaults = {lazy = true}, dev = {path = "~/workspace/nvim_plugins/"}, performance = {rtp = {disabled_plugins = {"netrwPlugin", "tarPlugin", "tutor", "zipPlugin", "tohtml", "gzip", "matchit", "matchparen"}}}}
local function use(...)
  local pkgs = {...}
  local plugins = {}
  for i = 1, a.count(pkgs), 2 do
    local name = pkgs[i]
    local opts = pkgs[(i + 1)]
    if (a.get(opts, "mod", nil) ~= nil) then
      local tbl_16_auto = {}
      for k, v in pairs(opts) do
        local k_17_auto, v_18_auto = nil, nil
        if (k == "mod") then
          local function _2_()
            return require(("dotfiles.plugin." .. v))
          end
          k_17_auto, v_18_auto = "config", _2_
        else
          k_17_auto, v_18_auto = k, v
        end
        if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
          tbl_16_auto[k_17_auto] = v_18_auto
        else
        end
      end
      opts = tbl_16_auto
    else
    end
    if ((a.get(opts, "dir", nil) ~= nil) or (a.get(opts, "url", nil) ~= nil)) then
      table.insert(plugins, opts)
    else
      table.insert(plugins, a.assoc(opts, 1, name))
    end
  end
  return lazy.setup(plugins, lazy_config)
end
local function _7_()
  return vim.cmd.colorscheme("srcery")
end
local function _8_()
  return require("notify").dismiss({silent = true, pending = true})
end
local function _9_()
  return math.floor((vim.o.lines * 0.75))
end
local function _10_()
  return math.floor((vim.o.columns * 0.75))
end
local function _11_()
  return require("noice").redirect(vim.fn.getcmdline())
end
local function _12_(plugin)
  return vim.opt.rtp:append((plugin.dir .. "/target/release"))
end
local function _13_()
  local function _14_()
    return require("parinfer").setup()
  end
  return vim.api.nvim_create_autocmd("VimEnter", {callback = _14_})
end
local function _15_()
  local snippy = require("snippy")
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs(({expr = true} or {})) do
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
    local function _19_()
      if snippy.can_jump(1) then
        return "<Plug>(snippy-next)"
      else
        return "<ESC>A"
      end
    end
    vim.keymap.set({"i", "s"}, "<C-l>", _19_, opts_1_auto)
  end
  local opts_1_auto
  do
    local tbl_16_auto = {}
    for k_2_auto, v_3_auto in pairs(({expr = true} or {})) do
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
  local function _24_()
    if snippy.can_jump(-1) then
      return "<Plug>(snippy-previous)"
    else
      return "<ESC>I"
    end
  end
  return vim.keymap.set({"i", "s"}, "<C-h>", _24_, opts_1_auto)
end
local function _26_()
  return require("dapui").toggle({})
end
local function _27_()
  return require("dapui").eval()
end
local function _28_()
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set({"x", "o"}, "aa", "<Plug>SidewaysArgumentTextobjA", opts_1_auto)
  end
  local opts_1_auto
  do
    local tbl_16_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
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
  return vim.keymap.set({"x", "o"}, "ia", "<Plug>SidewaysArgumentTextobjI", opts_1_auto)
end
local function _35_()
  local fzf = require("fzf-lua")
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "<leader>ff", fzf.files, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _42_()
      return fzf.files({cwd = "~/.config/nvim"})
    end
    vim.keymap.set("n", "<leader>fp", _42_, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "<leader>fs", fzf.live_grep_native, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "<leader>fb", fzf.buffers, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "<leader>bb", fzf.buffers, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "<leader>fh", fzf.help_tags, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "<leader>fk", fzf.keymaps, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "<leader>fl", fzf.blines, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "<leader>pl", fzf.lines, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "<leader>fo", fzf.oldfiles, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "<leader>fc", fzf.commands, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "<leader>fq", fzf.quickfix, opts_1_auto)
  end
  local opts_1_auto
  do
    local tbl_16_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
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
  return vim.keymap.set("n", "<leader>fg", fzf.git_bcommits, opts_1_auto)
end
local function _76_()
  return require("fundo").install()
end
local function _77_()
  local builtin = require("statuscol.builtin")
  local statuscol = require("statuscol")
  return statuscol.setup({relculright = true, segments = {{text = {"%s"}, click = "v:lua.ScSa"}, {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"}, {text = {builtin.foldfunc}, click = "v:lua.ScFa"}}})
end
local function _78_()
  local ufo = require("ufo")
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "zR", ufo.openAllFolds, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "zM", ufo.closeAllFolds, opts_1_auto)
  end
  local ftmap = {vim = "indent", fennel = "treesitter", python = "indent", git = "", sagaoutline = "", sagafinder = ""}
  local function _85_(bufnr, filetype, buftype)
    return ftmap[filetype]
  end
  return ufo.setup({provider_selector = _85_})
end
local function _86_()
  return require("dotfiles.qftf")
end
local function _87_()
  local illuminate = require("illuminate")
  return illuminate.configure({providers = {"lsp", "regex"}, modes_denylist = {"i"}, large_file_cutoff = 5000})
end
local function _88_()
  local surround = require("nvim-surround")
  local config = require("nvim-surround.config")
  local function _89_()
    return config.get_selection({motion = "a("})
  end
  local function _90_()
    return config.get_selection({motion = "a)"})
  end
  return surround.setup({surrounds = {["("] = {add = {"(", ")"}, find = _89_, delete = "^(.)().-(.)()$"}, [")"] = {add = {"( ", " )"}, find = _90_, delete = "^(. ?)().-( ?.)()$"}}, move_cursor = false})
end
local function _91_()
  return require("flash").jump()
end
local function _92_()
  return require("flash").treesitter()
end
local function _93_()
  return require("flash").remote()
end
local function _94_()
  return require("flash").treesitter_search()
end
local function _95_()
  return require("flash").toggle()
end
local function _96_()
  return require("nrpattern").setup()
end
local function _97_()
  local close_buffers = require("close_buffers")
  do
    local opts_1_auto
    do
      local tbl_16_auto = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _101_()
      return close_buffers.delete({type = "this"})
    end
    vim.keymap.set("n", "<leader>bk", _101_, opts_1_auto)
  end
  local opts_1_auto
  do
    local tbl_16_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
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
  local function _105_()
    return close_buffers.delete({type = "hidden"})
  end
  return vim.keymap.set("n", "<leader>bo", _105_, opts_1_auto)
end
local function _106_()
  local opts_1_auto
  do
    local tbl_16_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
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
  return vim.keymap.set({"n", "x"}, "<leader>sr", require("ssr").open, opts_1_auto)
end
local function _110_()
  vim.g.table_mode_corner = "|"
  return nil
end
local function _111_()
  return require("better_escape").setup({mappings = {i = {j = {k = "<Esc>"}}, t = {j = {k = "<Esc>"}}, s = {j = {k = "<Esc>"}}}})
end
return use("folke/lazy.nvim", {event = "VeryLazy"}, "Olical/nfnl", {branch = "main", lazy = false}, "Olical/conjure", {branch = "main", mod = "conjure", lazy = false}, "nvim-lua/plenary.nvim", {}, "nvim-tree/nvim-web-devicons", {mod = "devicons"}, "rhcher/srcery.nvim", {priority = 1000, config = _7_, lazy = false}, "nvim-lualine/lualine.nvim", {event = "VeryLazy", config = true, dependencies = "nvim-tree/nvim-web-devicons"}, "junegunn/fzf", {event = "VeryLazy", build = "./install --bin"}, "karb94/neoscroll.nvim", {event = "VeryLazy", config = true, cond = false}, "gbprod/substitute.nvim", {config = true, keys = {{"<leader>x", "<cmd>lua require('substitute.exchange').operator()<cr>"}, {"<leader>xx", "<cmd>lua require('substitute.exchange').line()<cr>"}, {"X", "<cmd>lua require('substitute.exchange').visual()<cr>", mode = "x"}, {"<leader>xc", "<cmd>lua require('substitute.exchange').cancel()<cr>"}}}, "rcarriga/nvim-notify", {keys = {{"<leader>un", _8_}}, opts = {timeout = 3000, background_colour = "#000000", max_height = _9_, max_width = _10_}}, "folke/noice.nvim", {event = "VeryLazy", dependencies = {"MunifTanjim/nui.nvim"}, keys = {{"<S-Enter>", _11_, mode = "c"}}, opts = {lsp = {progress = {enabled = false}, hover = {enabled = false}, override = {["cmp.entry.get_documentation"] = false, ["vim.lsp.util.convert_input_to_markdown_lines"] = false, ["vim.lsp.util.stylize_markdown"] = false}}, presets = {bottom_search = true, command_palette = true, long_message_to_split = true}, messages = {enabled = false}}, cond = false}, "nvim-treesitter/nvim-treesitter", {build = ":TSUpdate", mod = "treesitter", version = false}, "eraserhd/parinfer-rust", {ft = util["lisp-language"], config = _12_, build = "cargo build --release"}, "harrygallagher4/nvim-parinfer-rust", {ft = util["lisp-language"], config = _13_}, "hrsh7th/nvim-cmp", {dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "PaterJason/cmp-conjure", "hrsh7th/cmp-cmdline", "onsails/lspkind-nvim", "dcampos/nvim-snippy"}, mod = "completion", version = false}, "hrsh7th/cmp-cmdline", {event = "CmdlineEnter"}, "onsails/lspkind-nvim", {event = "LspAttach"}, "dcampos/nvim-snippy", {config = _15_}, "neovim/nvim-lspconfig", {dependencies = {"hrsh7th/cmp-nvim-lsp"}, mod = "nvim-lspconfig", lazy = false}, "mfussenegger/nvim-dap", {mod = "dap", dependencies = {"rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text"}, lazy = false}, "rcarriga/nvim-dap-ui", {keys = {{"<leader>du", _26_}, {"<leader>de", _27_, mode = {"n", "v"}}}, dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}, mod = "dap"}, "theHamsta/nvim-dap-virtual-text", {opts = {}, lazy = false}, "nvimdev/lspsaga.nvim", {dependencies = {"nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter"}, event = "LspAttach", mod = "lspsaga"}, "Wansmer/symbol-usage.nvim", {event = "LspAttach", opts = {vt_position = "end_of_line"}, cond = false}, "AndrewRadev/sideways.vim", {event = "VeryLazy", init = _28_}, "altermo/ultimate-autopair.nvim", {event = {"InsertEnter", "CmdlineEnter"}, branch = "v0.6", dependencies = {"nvim-treesitter/nvim-treesitter"}, mod = "auto-pairs"}, "stevearc/oil.nvim", {event = "VeryLazy", dependencies = {"nvim-tree/nvim-web-devicons"}, opts = {columns = {"icon", "permissions", "size", "mtime"}}}, "utilyre/sentiment.nvim", {version = "*", event = "VeryLazy", opts = {}}, "ibhagwan/fzf-lua", {cmd = "FzfLua", dependencies = {"nvim-tree/nvim-web-devicons"}, opts = {winopts = {split = "bot new", border = "single"}, copen = "bot new"}, init = _35_}, "tpope/vim-fugitive", {cmd = "Git"}, "junegunn/gv.vim", {cmd = "GV", dependencies = {"tpope/vim-fugitive"}}, "julienvincent/nvim-paredit", {ft = util["lisp-language"], mod = "nvim-paredit"}, "svban/YankAssassin.vim", {event = "VeryLazy"}, "kana/vim-textobj-user", {event = "VeryLazy", dependencies = {"glts/vim-textobj-comment"}}, "chrisgrieser/nvim-various-textobjs", {keys = {{"iv", "<cmd>lua require('various-textobjs').subword('inner')<CR>", mode = {"o", "x"}}, {"av", "<cmd>lua require('various-textobjs').subword('outer')<CR>", mode = {"o", "x"}}}}, "AndrewRadev/linediff.vim", {cmd = "Linediff"}, "tyru/open-browser.vim", {keys = {{"gx", "<Plug>(openbrowser-smart-search)", mode = {"n", "v"}}}}, "kevinhwang91/nvim-fundo", {dependencies = {"kevinhwang91/promise-async"}, event = "VeryLazy", build = _76_, config = true}, "kevinhwang91/nvim-ufo", {dependencies = {"kevinhwang91/promise-async", {"luukvbaal/statuscol.nvim", config = _77_}}, event = "VeryLazy", config = _78_}, "kevinhwang91/nvim-bqf", {ft = "qf", init = _86_, mod = "bqf"}, "RRethy/vim-illuminate", {event = {"BufReadPost", "BufNewFile"}, config = _87_}, "lukas-reineke/indent-blankline.nvim", {event = "VeryLazy", mod = "indent"}, "mbbill/undotree", {cmd = "UndotreeShow"}, "NvChad/nvim-colorizer.lua", {cmd = "ColorizerToggle", main = "colorizer", config = true}, "tpope/vim-repeat", {event = "VeryLazy"}, "kylechui/nvim-surround", {event = "VeryLazy", config = _88_}, "mhinz/vim-grepper", {keys = {"gs"}, mod = "grepper"}, "lewis6991/gitsigns.nvim", {event = {"BufReadPre", "BufNewFile"}, mod = "gitsigns"}, "akinsho/nvim-toggleterm.lua", {keys = {"<leader>ot", "<leader>oT"}, mod = "terminal"}, "folke/flash.nvim", {event = "VeryLazy", opts = {}, keys = {{"s", _91_, mode = {"n", "x", "o"}}, {"S", _92_, mode = {"n", "x", "o"}}, {"r", _93_, mode = "o"}, {"R", _94_, mode = {"x", "o"}}, {"<C-s>", _95_, mode = "c"}}}, "booperlv/nvim-gomove", {event = "VeryLazy", mod = "move"}, "zegervdv/nrpattern.nvim", {keys = {"<C-a>", "<C-x>"}, config = _96_}, "ThePrimeagen/harpoon", {keys = {"<leader>uu", "<leader>ua", "<leader>un", "<leader>up", "<leader>tc"}, dependencies = {"nvim-lua/plenary.nvim"}, mod = "harpoon"}, "danymat/neogen", {cmd = "Neogen", opts = {snippet_engine = "snippy"}}, "kazhala/close-buffers.nvim", {keys = {"<leader>bk", "<leader>bo"}, config = _97_}, "anuvyklack/hydra.nvim", {event = "VeryLazy", dependencies = {"anuvyklack/keymap-layer.nvim", "mrjones2014/smart-splits.nvim"}, mod = "hydra"}, "cshuaimin/ssr.nvim", {keys = {"<leader>sr"}, config = _106_}, "dhruvasagar/vim-table-mode", {cmd = "TableModeToggle", init = _110_}, "nvimdev/dashboard-nvim", {event = "VimEnter", mod = "dashboard", dependencies = {"nvim-tree/nvim-web-devicons"}, cond = false}, "gbprod/cutlass.nvim", {event = "VeryLazy", opts = {}}, "kevinhwang91/nvim-hlslens", {event = "VeryLazy", mod = "hlslens", dependencies = {"haya14busa/vim-asterisk"}}, "mg979/vim-visual-multi", {event = "VeryLazy"}, "max397574/better-escape.nvim", {event = "VeryLazy", config = _111_}, "sindrets/diffview.nvim", {cmd = "DiffviewOpen"}, "chrisgrieser/nvim-spider", {keys = {{"w", "<cmd>lua require('spider').motion('w')<CR>", mode = {"n", "o", "x"}}, {"e", "<cmd>lua require('spider').motion('e')<CR>", mode = {"n", "o", "x"}}, {"b", "<cmd>lua require('spider').motion('b')<CR>", mode = {"n", "o", "x"}}, {"ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = {"n", "o", "x"}}}}, "tiagovla/scope.nvim", {config = true, lazy = false}, "nvim-dd.git", {url = "https://gitlab.com/yorickpeterse/nvim-dd.git", event = "VeryLazy", opts = {timeout = 200}}, "willothy/flatten.nvim", {config = true, priority = 1001, lazy = false}, "Julian/lean.nvim", {event = {"BufReadPre *.lean", "BufNewFile *.lean"}, dependencies = {"neovim/nvim-lspconfig", "nvim-lua/plenary.nvim"}, opts = {lsp = {}, mappings = true}}, "OXY2DEV/markview.nvim", {dependencies = {"nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons"}, lazy = false})
