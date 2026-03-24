return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        local ts = require('nvim-treesitter')
        ts.setup()
        ts.install({ "lua", "python", "rust", "c", "cpp", "vim", "vimdoc", "query" })
    end,
}
