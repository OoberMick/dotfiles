-- Require all Lua files in this directory (lua/autocmds/*.lua)
-- so that `require("autocmds")` loads them all.
local M = {}

local autocmds_dir = vim.fn.stdpath("config") .. "/lua/autocmds"
local files = vim.fn.glob(autocmds_dir .. "/*.lua", true, true)

for _, file in ipairs(files) do
  local name = vim.fn.fnamemodify(file, ":t:r") -- filename without extension
  if name ~= "init" then
    require("autocmds." .. name)
  end
end

return M
