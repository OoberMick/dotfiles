return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
        whitespace = {
            highlight = { "Whitespace" }
        },
        indent = {
            highlight = { "Whitespace" }
        }
    },
    config = function(_, opts)
        require('ibl').setup(opts)
    end,
}
