return {
    'saghen/blink.cmp',
    version = '1.*',
    opts = {
        fuzzy = { implementation = "prefer_rust_with_warning" },
        keymap = {
            preset = 'enter'
        },
        cmdline = {
            enabled = true,
            sources = function()
                local type = vim.fn.getcmdtype()
                if type == '/' or type == '?' then return { 'buffer' } end
                if type == ':' then return { 'cmdline' } end
                return {}
            end,
            completion = {
                ghost_text = { enabled = true },
                menu = { auto_show = true },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = true,
                    }
                }
            }
        },
        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                },
            },
            keyword = {
                range = 'full',
            },
        },
    }
}
