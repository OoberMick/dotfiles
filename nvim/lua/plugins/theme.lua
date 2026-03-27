return {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('nightfox').setup({
            groups = {
                carbonfox = {
                    Normal = { bg = "#000000" }, -- Actually black
                    Comment = { fg = "#a6a8aa" }, -- Lighter comments
                },
            },
        })
        vim.cmd.colorscheme("carbonfox")
    end,
}
