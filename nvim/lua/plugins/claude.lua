return {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
        git_repo_cwd = true, -- Automatically finds your project root
    },
    keys = {
        { "<leader>ac", "<cmd>ClaudeCode<cr>",      desc = "Toggle Claude" },
        { "<leader>as", ":ClaudeCodeSend<cr>",      mode = "v", desc = "Send Selection to Claude" },
        { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer to context" },
    },
}
