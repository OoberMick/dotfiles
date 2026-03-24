vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        require('config.ftplugin').treesitter()
    end,
})
