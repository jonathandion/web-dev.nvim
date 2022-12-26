-- @commands
local user_cmd = vim.api.nvim_create_user_command

user_cmd('Note', 'e ~/note.txt', {})
user_cmd('Repl', 'e ~/code/repl/index.ts', {})
user_cmd('Pad', 'e /tmp/scratchpad', {})
user_cmd('Wiki', 'e ~/code/wiki', {})
user_cmd('Gists', 'e ~/code/gists', {})
user_cmd('PrettyJson', ":%!jq '.'", {})
user_cmd(
  'Ranger',
  "FloatermNew ranger",
  { bang = true }
)

-- @keymaps
local keyset = vim.keymap.set
keyset("n", "-", ":Ranger<cr>")
keyset("n", "<leader>n", ":Note<cr>")
