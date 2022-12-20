-- Commands
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
  {bang = true}
)
user_cmd("Cppath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- Functions
function _G.abbreviate_or_noop(input, output)
  local cmdtype = vim.fn.getcmdtype()
  local cmdline = vim.fn.getcmdline()

  if (cmdtype == ":" and cmdline == input) then
    return output
  else
    return input
  end
end

function _G.cmd_alias(alias, cmd)
  vim.api.nvim_command("cabbrev <expr> " .. alias .. " " .. "v:lua.abbreviate_or_noop('" .. alias .. "', '" .. cmd .. "')")
end

cmd_alias("node", "! node %")
cmd_alias("tsnode", "! ts-node %")

-- Keymaps
local keyset = vim.keymap.set

keyset("n", "-", ":Ranger<cr>")
