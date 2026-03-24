-- faster CursorHold events
vim.o.updatetime = 250

local diag = vim.diagnostic
local augroup = vim.api.nvim_create_augroup("LspDiagnosticsFloat", { clear = true })

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  group = augroup,
  callback = function()
    -- show float at cursor without taking focus
    diag.open_float(nil, { focus = false })
  end,
})
