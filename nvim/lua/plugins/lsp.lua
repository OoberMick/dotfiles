return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = { "lua_ls", "rust_analyzer", "clangd", "ruff" },
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		{ "neovim/nvim-lspconfig" },
	},
	config = function(_, opts)
		local mason_lsp = require("mason-lspconfig")

		-- Setup Mason
		require("mason").setup()
		mason_lsp.setup(opts)

		-- Get capabilities from blink.cmp
		local capabilities = require('blink.cmp').get_lsp_capabilities()
		vim.lsp.config('*', { capabilities = capabilities })

		-- Define custom settings for Lua
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
				},
			},
		})

		-- The "Dynamic Hook": Enable every server Mason has installed
		-- This covers both 'ensure_installed' AND things you clicked in the UI
		for _, server_name in ipairs(mason_lsp.get_installed_servers()) do
			vim.lsp.enable(server_name)
		end

		-- LSP keybindings
		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function(args)
				local opts = { buffer = args.buf }
                opts.desc = "Definition"
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                opts.desc = "Declaration"
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                opts.desc = "Implementation"
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                opts.desc = "References"
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                opts.desc = "Hover"
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                opts.desc = "Rename"
				vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
                opts.desc = "Code Action"
				vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, opts)
                opts.desc = "Format"
				vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, opts)
			end,
		})
	end,
}
