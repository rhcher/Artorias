-- [nfnl] fnl/dotfiles/plugin/grepper.fnl
vim.keymap.set("n", "<leader>*", ":Grepper -tool rg -cword -noprompt<CR>", {noremap = true})
vim.g.grepper = {tools = {"rg", "git"}, dir = "repo,file", simple_prompt = 1, searchreg = 1, stop = 50000, rg = {grepprg = "rg -H --no-heading --vimgrep --smart-case", grepformat = "%f:%l:%c:%m,%f:%l:%m"}}
vim.cmd("let g:grepper.repo = ['.git', '.hg', '.svn', 'stack.yaml', 'dune-project', '.ccls-root', 'Cargo.toml', 'compile_commands.json']")
vim.cmd("aug Grepper\n            au!\n            au User Grepper ++nested call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': '\\%#' . getreg('/')}}}) | bo cope\n          aug END")
vim.cmd("command! Todo :Grepper -noprompt -tool git -grepprg git grep -nIi '\\(TODO\\|FIXME\\)'")
return vim.cmd("nmap gs <plug>(GrepperOperator)\n          xmap gs <plug>(GrepperOperator)")
