return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'linrongbin16/lsp-progress.nvim'
    },
    config = function()
        require("lualine").setup({
            options = {
                theme = "auto",
                icons_enabled = true,
                globalstatus = true,
                section_separators = "",
                component_separators = "",
            },
            sections = {
                lualine_c = {
                    function()
                        return require('lsp-progress').progress()
                    end,
                },
                lualine_x = {
                    {
                        function()
                            return "PASTE"
                        end,
                        cond = function()
                            return vim.opt.paste:get()
                        end,
                        color = { fg = "#ffffff", bg = "#ff5f00", gui = "bold" },
                    },
                    "encoding", "fileformat", "filetype"
                },
            }
        })
        require('lsp-progress').setup()
        vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            group = "lualine_augroup",
            pattern = 'LspProgressStatusUpdated',
            callback = require('lualine').refresh
        })
    end,
}
