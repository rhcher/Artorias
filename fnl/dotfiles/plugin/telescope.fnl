(module dotfiles.plugin.telescope
  {autoload {nvim aniseed.nvim
             util dotfiles.util
             telescope telescope
             actions telescope.actions}})

(telescope.setup
  {:defaults
   {:vimgrep_arguments ["rg" "--color=never" "--no-heading"
                        "--with-filename" "--line-number" "--column"
                        "--smart-case" "--hidden" "--follow"
                        "-g" "!.git/"]
    :mappings {:i {:<esc> actions.close}}
    :sorting_strategy "ascending"
    :layout_config
      {:horizontal {:prompt_position "top"}}}})

(util.lnnoremap :ff "Telescope find_files hidden=true")
(util.lnnoremap :f- "Telescope file_browser")
(util.lnnoremap :fg "Telescope live_grep")
(util.lnnoremap :* "Telescope grep_string")
(util.lnnoremap :fb "Telescope buffers")
(util.lnnoremap :bb "Telescope buffers")
(util.lnnoremap :fh "Telescope help_tags")
(util.lnnoremap :fk "Telescope keymaps")
(util.lnnoremap :fm "Telescope marks")
(util.lnnoremap :fo "Telescope oldfiles")
(util.lnnoremap :ft "Telescope filetypes")
(util.lnnoremap :fc "Telescope commands")
(util.lnnoremap :fC "Telescope command_history")
(util.lnnoremap :fq "Telescope quickfix")
(util.lnnoremap :fl "Telescope loclist")
(util.lnnoremap :fsa "Telescope lsp_code_actions")
(util.lnnoremap :fsi "Telescope lsp_implementations")
(util.lnnoremap :fsr "Telescope lsp_references")
(util.lnnoremap :fsS "Telescope lsp_document_symbols")
(util.lnnoremap :fss "Telescope lsp_workspace_symbols")
