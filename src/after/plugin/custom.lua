-- @commands
local user_cmd = vim.api.nvim_create_user_command

user_cmd("Note", "e ~/note.txt", {})
user_cmd("Repl", "e ~/code/repl/index.ts", {})
user_cmd("Pad", "e /tmp/scratchpad", {})
user_cmd("Wiki", "e ~/code/wiki", {})
user_cmd("Gists", "e ~/code/gists", {})
user_cmd("PrettyJson", ":%!jq '.'", {})
user_cmd("Node", "! npx node %", {})
user_cmd("Ts", "! npx ts-node %", {})
user_cmd("Styling", "! npx stylelint --fix %", {})

-- @keymaps
local keyset = vim.keymap.set
keyset("n", "<leader>n", ":Note<cr>")
