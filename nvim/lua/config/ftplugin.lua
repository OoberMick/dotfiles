local M = {}

function M.treesitter()
    pcall(vim.treesitter.start)
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    return M
end

return M
