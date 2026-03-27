vim.g.loaded_netrw       = 1                     -- disable netrw
vim.g.loaded_netrwPlugin = 1
vim.opt.compatible       = false                 -- disable compatibility to old-time vi
vim.opt.showmatch        = true                  -- show matching
vim.opt.hlsearch         = true                  -- highlight search
vim.opt.incsearch        = true                  -- incremental search
vim.opt.tabstop          = 4                     -- number of columns occupied by a tab
vim.opt.softtabstop      = 4                     -- see multiple spaces as tabstops so <BS> does the right thing
vim.opt.expandtab        = true                  -- converts tabs to white space
vim.opt.shiftwidth       = 4                     -- width for autoindents
vim.opt.autoindent       = true                  -- indent a new line the same amount as the line just typed
vim.opt.number           = true                  -- add line numbers
vim.opt.wildmode         = { 'longest', 'list' } -- get bash-like tab completions
vim.opt.clipboard        = 'unnamedplus'         -- using system clipboard
vim.opt.ttyfast          = true                  -- Speed up scrolling in Vim
vim.opt.guicursor        = ''                    -- Disable gui cursor
vim.opt.signcolumn       = 'yes'                 -- Force the sign column on
vim.opt.ignorecase       = true                  -- Ignore when searching
vim.opt.smartcase        = true                  -- Unless I use capitales
vim.opt.selection        = "inclusive"           -- Include where the cursor is
vim.opt.colorcolumn      = '80'                  -- Add a line a column 80
vim.opt.laststatus       = 3                     -- Global statusline
vim.opt.showmode         = false                 -- Hide the default -- INSERT -- text
vim.opt.autochdir        = true                  -- cwd follows file
vim.opt.spelllang        = 'en_gb'               -- Set spell checking language
vim.opt.scrolloff        = 8                     -- Start scrolling when we're 8 lines from the edge
vim.opt.foldlevel        = 99
vim.opt.foldlevelstart   = 99

require('autocmds.init')
require("config.lazy")

--vim.keymap.set('n', '<leader>t', '<Cmd>NvimTre/scpeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>,', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>.', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>c', '<Cmd>BufferClose<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>', { silent = true })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = "Exit terminal mode" })

local tb = require('telescope.builtin')
--vim.keymap.set('n', 'aleader>ff', tb.find_files, { desc = 'Telescope find files' })
vim.keymap.set("n", "<leader>ff", function()
    require("telescope").extensions.file_browser.file_browser()
end, { desc = "Telescope file browser" })
vim.keymap.set('n', '<leader>fg', tb.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', tb.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', tb.help_tags, { desc = 'Telescope help tags' })

-- vim.keymap.set('n', '<leader>p', function()
--     vim.opt.paste = not vim.opt.paste:get()
--     print("Paste mode: " .. tostring(vim.opt.paste:get()))
-- end, { desc = "Toggle paste mode" }
-- )

-- Change 'BlinkCmpGhostText' to the colour of comments
vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "Comment", italic = true })

-- Define groups for which-key
local wk = require("which-key")
wk.add({
    { "<leader>f", name = "Find" },
    { "<leader>l", name = "LSP" },
    { "<leader>a", name = "Claude" }
})

vim.keymap.set('n', "<M-Up>", "<cmd>m-2<CR>", { desc = "move line one up without touching registers" })
vim.keymap.set('n', "<M-Down>", "<cmd>m+1<CR>", { desc = "move line one down without touching registers" })
vim.keymap.set('v', "<M-Up>", ":m '<-2<CR>gv", { desc = "move selection one up without touching registers" })
vim.keymap.set('v', "<M-Down>", ":m '>+1<CR>gv", { desc = "move selection one up without touching registers" })

-- Remote paste magic
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy '+',
    ['*'] = require('vim.ui.clipboard.osc52').copy '*',
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste '+',
    ['*'] = require('vim.ui.clipboard.osc52').paste '*',
  },
}
