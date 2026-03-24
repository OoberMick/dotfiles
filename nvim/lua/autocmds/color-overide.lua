vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b4252" })
        vim.api.nvim_set_hl(0, "IblScope",  { fg = "#88c0d0" })
        vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#3b4252" })
    end,
})
