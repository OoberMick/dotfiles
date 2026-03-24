local M = {}

function M.treesitter()
    pcall(vim.treesitter.start)
    return M
end

return M
