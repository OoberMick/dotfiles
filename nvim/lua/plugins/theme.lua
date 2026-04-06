return {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('nightfox').setup({
            groups = {
                carbonfox = {
                    Normal = { bg = "#000000" },
                    Comment = { fg = "#a6a8aa" },
                    Whitespace = { fg = "#707070" },
                },
            },
        })

        vim.cmd.colorscheme("carbonfox")
    end,
}
