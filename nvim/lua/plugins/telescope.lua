return {
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- optional but recommended
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require('telescope').setup({
                extensions = {
                    file_browser = {
                        hijack_netrw = true,
                    }
                }
            })
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('file_browser')
        end,
    }
}
