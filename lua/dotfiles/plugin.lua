-- [nfnl] fnl/dotfiles/plugin.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
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
      local tbl_21_ = {}
      for k, v in pairs(opts) do
        local k_22_, v_23_
        if (k == "mod") then
          local function _2_()
            return require(("dotfiles.plugin." .. v))
          end
          k_22_, v_23_ = "config", _2_
        else
          k_22_, v_23_ = k, v
        end
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts = tbl_21_
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
local function _7_(plugin)
  return vim.opt.rtp:append((plugin.dir .. "/target/release"))
end
local function _8_()
  local function _9_()
    return require("parinfer").setup()
  end
  return vim.api.nvim_create_autocmd("VimEnter", {callback = _9_})
end
local function _10_()
  local snippy = require("snippy")
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs(({expr = true} or {})) do
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
    local function _14_()
      if snippy.can_jump(1) then
        return "<Plug>(snippy-next)"
      else
        return "<ESC>A"
      end
    end
    vim.keymap.set({"i", "s"}, "<C-l>", _14_, opts_1_auto)
  end
  local opts_1_auto
  do
    local tbl_21_ = {}
    for k_2_auto, v_3_auto in pairs(({expr = true} or {})) do
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
  local function _19_()
    if snippy.can_jump(-1) then
      return "<Plug>(snippy-previous)"
    else
      return "<ESC>I"
    end
  end
  return vim.keymap.set({"i", "s"}, "<C-h>", _19_, opts_1_auto)
end
local function _21_()
  return require("dapui").toggle({})
end
local function _22_()
  return require("dapui").eval()
end
local function _23_()
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set({"x", "o"}, "aa", "<Plug>SidewaysArgumentTextobjA", opts_1_auto)
  end
  local opts_1_auto
  do
    local tbl_21_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
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
  return vim.keymap.set({"x", "o"}, "ia", "<Plug>SidewaysArgumentTextobjI", opts_1_auto)
end
local function _30_()
  return require("fundo").install()
end
local function _31_()
  local builtin = require("statuscol.builtin")
  local statuscol = require("statuscol")
  return statuscol.setup({relculright = true, segments = {{text = {"%s"}, click = "v:lua.ScSa"}, {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"}, {text = {builtin.foldfunc}, click = "v:lua.ScFa"}}})
end
local function _32_()
  local ufo = require("ufo")
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "zR", ufo.openAllFolds, opts_1_auto)
  end
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    vim.keymap.set("n", "zM", ufo.closeAllFolds, opts_1_auto)
  end
  local ftmap = {vim = "indent", fennel = "treesitter", python = "indent", git = "", sagaoutline = "", sagafinder = ""}
  local function _39_(bufnr, filetype, buftype)
    return ftmap[filetype]
  end
  return ufo.setup({provider_selector = _39_})
end
local function _40_()
  return require("dotfiles.qftf")
end
local function _41_()
  local illuminate = require("illuminate")
  return illuminate.configure({providers = {"lsp", "regex"}, modes_denylist = {"i"}, large_file_cutoff = 5000})
end
local function _42_()
  local surround = require("nvim-surround")
  local config = require("nvim-surround.config")
  local function _43_()
    return config.get_selection({motion = "a("})
  end
  local function _44_()
    return config.get_selection({motion = "a)"})
  end
  return surround.setup({surrounds = {["("] = {add = {"(", ")"}, find = _43_, delete = "^(.)().-(.)()$"}, [")"] = {add = {"( ", " )"}, find = _44_, delete = "^(. ?)().-( ?.)()$"}}, move_cursor = false})
end
local function _45_()
  return require("flash").jump()
end
local function _46_()
  return require("flash").treesitter()
end
local function _47_()
  return require("flash").remote()
end
local function _48_()
  return require("flash").treesitter_search()
end
local function _49_()
  return require("flash").toggle()
end
local function _50_()
  return require("nrpattern").setup()
end
local function _51_()
  local close_buffers = require("close_buffers")
  do
    local opts_1_auto
    do
      local tbl_21_ = {}
      for k_2_auto, v_3_auto in pairs((nil or {})) do
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
    local function _55_()
      return close_buffers.delete({type = "this"})
    end
    vim.keymap.set("n", "<leader>bk", _55_, opts_1_auto)
  end
  local opts_1_auto
  do
    local tbl_21_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
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
  local function _59_()
    return close_buffers.delete({type = "hidden"})
  end
  return vim.keymap.set("n", "<leader>bo", _59_, opts_1_auto)
end
local function _60_()
  local opts_1_auto
  do
    local tbl_21_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
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
  return vim.keymap.set({"n", "x"}, "<leader>sr", require("ssr").open, opts_1_auto)
end
local function _64_()
  vim.g.table_mode_corner = "|"
  return nil
end
local function _65_()
  return require("better_escape").setup({mappings = {i = {j = {k = "<Esc>"}}}, default_mappings = false})
end
local function _66_()
  local codediff = require("codediff")
  do local _ = codediff.setup end
  return {highlights = {line_insert = "DiffAdd", line_delete = "DiffDelete", char_insert = "DiffText", char_delete = "DiffDelete", char_brightness = "DiffText"}}
end
local function _67_()
  return require("sidekick.cli").toggle()
end
local function _68_()
  return require("sidekick.cli").select({filter = {installed = true}})
end
local function _69_()
  return require("sidekick.cli").send({msg = "{this}"})
end
local function _70_()
  return require("sidekick.cli").send({msg = "{selection}"})
end
local function _71_()
  return require("sidekick.cli").prompt()
end
local function _72_()
  return require("sidekick.cli").focus()
end
return use("folke/lazy.nvim", {event = "VeryLazy"}, "Olical/nfnl", {branch = "main", lazy = false}, "Olical/conjure", {branch = "main", mod = "conjure", lazy = false}, "nvim-lua/plenary.nvim", {}, "rhcher/srcery.nvim", {priority = 1000, lazy = false}, "wtfox/jellybeans.nvim", {priority = 1000, opts = {}, lazy = false}, "rhcher/vim-paper", {priority = 1000, lazy = false}, "nvim-lualine/lualine.nvim", {config = true, lazy = false}, "folke/snacks.nvim", {priority = 1000, mod = "snacks", lazy = false}, "junegunn/fzf", {event = "VeryLazy", build = "./install --bin"}, "gbprod/substitute.nvim", {config = true, keys = {{"<leader>x", "<cmd>lua require('substitute.exchange').operator()<cr>"}, {"<leader>xx", "<cmd>lua require('substitute.exchange').line()<cr>"}, {"X", "<cmd>lua require('substitute.exchange').visual()<cr>", mode = "x"}, {"<leader>xc", "<cmd>lua require('substitute.exchange').cancel()<cr>"}}}, "nvim-treesitter/nvim-treesitter", {build = ":TSUpdate", mod = "treesitter", lazy = false}, "eraserhd/parinfer-rust", {ft = util["lisp-language"], config = _7_, build = "cargo build --release"}, "harrygallagher4/nvim-parinfer-rust", {ft = util["lisp-language"], config = _8_}, "saghen/blink.cmp", {event = {"InsertEnter", "CmdlineEnter"}, mod = "completion", build = "cargo build --release", version = false}, "hrsh7th/nvim-ix", {dependencies = {"hrsh7th/nvim-cmp-kit"}, mod = "completion", cond = false, lazy = false}, "dcampos/nvim-snippy", {config = _10_}, "mfussenegger/nvim-dap", {mod = "dap", dependencies = {"rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text"}, lazy = false}, "rcarriga/nvim-dap-ui", {keys = {{"<leader>du", _21_}, {"<leader>de", _22_, mode = {"n", "v"}}}, dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}, mod = "dap"}, "theHamsta/nvim-dap-virtual-text", {opts = {}, lazy = false}, "nvimdev/lspsaga.nvim", {dependencies = {"nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter"}, event = "LspAttach", mod = "lspsaga"}, "AndrewRadev/sideways.vim", {event = "VeryLazy", init = _23_, cond = false}, "altermo/ultimate-autopair.nvim", {branch = "v0.6", dependencies = {"nvim-treesitter/nvim-treesitter"}, mod = "auto-pairs", lazy = false}, "utilyre/sentiment.nvim", {event = "VeryLazy", opts = {}, version = false}, "tpope/vim-fugitive", {cmd = "Git"}, "junegunn/gv.vim", {cmd = "GV", dependencies = {"tpope/vim-fugitive"}}, "julienvincent/nvim-paredit", {ft = util["lisp-language"], mod = "nvim-paredit"}, "svban/YankAssassin.vim", {event = "VeryLazy"}, "kana/vim-textobj-user", {event = "VeryLazy", dependencies = {"glts/vim-textobj-comment"}}, "chrisgrieser/nvim-various-textobjs", {keys = {{"iv", "<cmd>lua require('various-textobjs').subword('inner')<CR>", mode = {"o", "x"}}, {"av", "<cmd>lua require('various-textobjs').subword('outer')<CR>", mode = {"o", "x"}}}}, "AndrewRadev/linediff.vim", {cmd = "Linediff"}, "tyru/open-browser.vim", {keys = {{"gx", "<Plug>(openbrowser-smart-search)", mode = {"n", "v"}}}}, "kevinhwang91/nvim-fundo", {dependencies = {"kevinhwang91/promise-async"}, event = "VeryLazy", build = _30_, config = true}, "kevinhwang91/nvim-ufo", {dependencies = {"kevinhwang91/promise-async", {"luukvbaal/statuscol.nvim", config = _31_}}, event = "VeryLazy", config = _32_}, "kevinhwang91/nvim-bqf", {ft = "qf", init = _40_, mod = "bqf"}, "RRethy/vim-illuminate", {event = {"BufReadPost", "BufNewFile"}, config = _41_}, "mbbill/undotree", {cmd = "UndotreeShow"}, "tpope/vim-repeat", {event = "VeryLazy"}, "kylechui/nvim-surround", {event = "VeryLazy", config = _42_}, "mhinz/vim-grepper", {keys = {"gs"}, mod = "grepper"}, "lewis6991/gitsigns.nvim", {event = {"BufReadPre", "BufNewFile"}, mod = "gitsigns"}, "folke/flash.nvim", {event = "VeryLazy", opts = {modes = {char = {enabled = false}}}, keys = {{"s", _45_, mode = {"n", "x", "o"}}, {"S", _46_, mode = {"n", "x", "o"}}, {"r", _47_, mode = "o"}, {"R", _48_, mode = {"x", "o"}}, {"<C-s>", _49_, mode = "c"}}}, "booperlv/nvim-gomove", {event = "VeryLazy", mod = "move"}, "zegervdv/nrpattern.nvim", {keys = {"<C-a>", "<C-x>"}, config = _50_}, "ThePrimeagen/harpoon", {keys = {"<leader>uu", "<leader>ua", "<leader>un", "<leader>up", "<leader>tc"}, branch = "harpoon2", dependencies = {"nvim-lua/plenary.nvim"}, mod = "harpoon"}, "danymat/neogen", {cmd = "Neogen", opts = {snippet_engine = "snippy"}}, "kazhala/close-buffers.nvim", {keys = {"<leader>bk", "<leader>bo"}, config = _51_}, "anuvyklack/hydra.nvim", {event = "VeryLazy", dependencies = {"anuvyklack/keymap-layer.nvim", "mrjones2014/smart-splits.nvim"}, mod = "hydra"}, "cshuaimin/ssr.nvim", {keys = {"<leader>sr"}, config = _60_}, "dhruvasagar/vim-table-mode", {cmd = "TableModeToggle", init = _64_}, "kevinhwang91/nvim-hlslens", {event = "VeryLazy", mod = "hlslens", dependencies = {"haya14busa/vim-asterisk"}}, "mg979/vim-visual-multi", {event = "VeryLazy"}, "max397574/better-escape.nvim", {event = "VeryLazy", config = _65_}, "esmuellert/vscode-diff.nvim", {dependencies = {"MunifTanjim/nui.nvim"}, cmd = "CodeDiff", branch = "next", config = _66_}, "chrisgrieser/nvim-spider", {keys = {{"w", "<cmd>lua require('spider').motion('w')<CR>", mode = {"n", "o", "x"}}, {"e", "<cmd>lua require('spider').motion('e')<CR>", mode = {"n", "o", "x"}}, {"b", "<cmd>lua require('spider').motion('b')<CR>", mode = {"n", "o", "x"}}, {"ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = {"n", "o", "x"}}}}, "tiagovla/scope.nvim", {config = true, lazy = false}, "nvim-dd.git", {url = "https://gitlab.com/yorickpeterse/nvim-dd.git", event = "VeryLazy", opts = {timeout = 200}}, "willothy/flatten.nvim", {config = true, priority = 1001, lazy = false}, "Julian/lean.nvim", {event = {"BufReadPre *.lean", "BufNewFile *.lean"}, dependencies = {"nvim-lua/plenary.nvim"}, opts = {lsp = {}, mappings = true}}, "MeanderingProgrammer/render-markdown.nvim", {dependencies = {"nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim"}, ft = {"markdown"}, opts = {heading = {position = "inline", icons = {"\243\176\188\143 ", "\243\176\142\168 "}}, code = {language_name = false}}}, "nvim-mini/mini.nvim", {keys = {{"<leader>e", "<cmd>lua MiniFiles.open()<CR>"}}, mod = "mini", version = false}, "tani/dmacro.vim", {keys = {{"<C-y>", "<Plug>(dmacro-play-macro)", mode = {"i", "n"}}}, lazy = false}, "nvzone/typr", {dependencies = "nvzone/volt", opts = {}, cmd = {"Typr", "TyprStats"}}, "folke/sidekick.nvim", {keys = {{"<leader>aa", _67_, desc = "Sidekick Toggle CLI"}, {"<leader>as", _68_, desc = "Sidekick Select CLI"}, {"<leader>at", _69_, desc = "Send this", mode = {"x", "n"}}, {"<leader>av", _70_, desc = "Send Visual Selection", mode = {"x"}}, {"<leader>ap", _71_, desc = "Sidekick Select Prompt", mode = {"n", "x"}}, {"<c-.>", _72_, desc = "Sidekick Switch Focus", mode = {"n", "x", "i", "t"}}}, opts = {cli = {mux = {backend = "zellij", enabled = false}}}})
