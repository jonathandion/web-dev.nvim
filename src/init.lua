local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.cmd([[packadd packer.nvim]])
end

-- @plugins
require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- Coding plugins
  use("janko-m/vim-test") --  Run tests quickly

  -- Git plugins
  use("tpope/vim-fugitive") --  Git wrapper
  use("ruanyl/vim-gh-line") --  Open GitHub file at line
  use("junegunn/gv.vim") --  Git commit browser

  -- Utility plugins
  use("jremmen/vim-ripgrep") --  Grep on steroids
  use("ThePrimeagen/harpoon") --  Bookmark management
  use("junegunn/vim-peekaboo") --  Preview registers
  use("machakann/vim-highlightedyank") --  Highlight yanked text
  use("easymotion/vim-easymotion") --  Move fast

  -- Text manipulation plugins
  use("tpope/vim-surround") --  Surround text objects
  use("wellle/targets.vim") --  Additional text objects
  use("mg979/vim-visual-multi") --  Multiple cursors
  use("tpope/vim-commentary") --  Comment out code
  use("tpope/vim-repeat") --  Repeat commands
  use("tpope/vim-sleuth") --  Detect indentation
  use("tpope/vim-unimpaired") --  Pairs of handy bracket mappings
  use("andrewradev/splitjoin.vim") --  Split/join lines
  use("raimondi/delimitmate") --  Auto closing quotes, brackets, etc

  -- UI plugins
  use("ellisonleao/gruvbox.nvim") --  Color scheme
  use("mhinz/vim-startify") --  Custom start screen
  use("nvim-lualine/lualine.nvim") --  Fancy statusline
  use("lewis6991/gitsigns.nvim") --  Git signs

  -- File explorer plugins
  use("tpope/vim-vinegar")
  use("unblevable/quick-scope") --  Netrw extension
  use("voldikss/vim-floaterm") --  Floating terminal
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0", --  Fuzzy finder
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  use("nvim-telescope/telescope-file-browser.nvim") --  Fuzzy file browser

  -- Syntax plugins
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) --  Syntax highlighting

  -- LSP plugins
  use("github/copilot.vim") --  AI code completion
  use("dnlhc/glance.nvim") -- Preview definitions, type definitions, references, implementations like vscode peek.
  use("williamboman/mason.nvim") --  Easily install and manage LSP servers, DAP servers, linters, and formatters.
  use({
    "VonHeikemen/lsp-zero.nvim",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },

      -- UI
      { "j-hui/fidget.nvim" },
    },
  })

  if is_bootstrap then
    require("packer").sync()
  end
end)

if is_bootstrap then
  print("==================================")
  print("    Plugins are being installed")
  print("    Wait until Packer completes,")
  print("       then restart nvim")
  print("==================================")
  return
end

-- Netrw config (file explorer)
vim.g.netrw_banner = 1
vim.g.netrw_liststyle = 4
vim.g.netrw_localrmdir = "rm -r"
vim.g.netrw_hide = 0

-- Startify config (start screen)
vim.g.startify_change_to_dir = 0
vim.g.startify_lists = {
  { header = { ("   Recent Files in: " .. vim.fn.getcwd()) }, type = "dir" },
}

-- Glance
require("glance").setup()

-- Telescope (fuzzy finder)
require("telescope").setup({
  defaults = {
    file_ignore_patterns = {
      ".git",
    },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      mappings = {
        ["i"] = {},
        ["n"] = {},
      },
    },
  },
})
local telescope = require("telescope.builtin")

-- Harpoon (bookmarks manager)
require("harpoon").setup()
require("telescope").load_extension("harpoon")

-- Treesitter (syntax highlight)
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "bash",
    "json",
    "javascript",
    "typescript",
    "astro",
  },
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

-- Gitsigns (git icons)
require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
})

-- Lualine (statusline)
require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "gruvbox",
    component_separators = "|",
    section_separators = "",
  },
})

-- Floaterm
vim.g.floaterm_opener = "edit"

-- Lsp
-- turn on lsp status information
require("fidget").setup()

-- Mason
require("mason").setup()
local lsp = require("lsp-zero")
lsp.preset("recommended")

-- disable defaults mappings
lsp.set_preferences({
  set_lsp_keymaps = false,
})

-- lsp servers based on: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
lsp.ensure_installed({
  -- web
  "html",
  "tsserver",
  "cssls",
  "stylelint_lsp",
  "eslint",
  "marksman",

  -- web3/blockchain
  "solang",

  -- devops/infrastructure
  "bashls",
  "sumneko_lua",
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
  ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with gitub/copilot plugin
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
})

lsp.on_attach(function(_, bufnr)
  SetCustomLspMappings(bufnr)
end)

lsp.nvim_workspace()
lsp.setup()

-- theme
vim.cmd([[colorscheme gruvbox]])

-- @options
-- space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.wo.number = true
vim.o.path = table.concat({ "**" })
vim.o.background = "dark"
vim.o.backup = false
vim.o.breakindent = true
vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.guicursor = "" -- fat cursor
vim.o.history = 500
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.laststatus = 2
vim.o.magic = true
vim.o.shiftwidth = 2
vim.o.showmatch = true
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smarttab = true
vim.o.so = 7
vim.o.softtabstop = 0
vim.o.tabstop = 2
vim.o.timeoutlen = 500
vim.o.title = true
vim.o.ttimeout = true
vim.o.ttimeoutlen = 10
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.wildmenu = true
vim.o.wildmode = "full"
vim.o.wrap = true
vim.o.writebackup = false

-- custom file types
vim.filetype.add({
  extension = {
    eslintrc = "json",
    prettierrc = "json",
    mdx = "markdown",
    mjml = "html",
  },
  pattern = {
    [".*%.env.*"] = "sh",
  },
})

-- @functions
function _G.abbreviate_or_noop(input, output)
  local cmdtype = vim.fn.getcmdtype()
  local cmdline = vim.fn.getcmdline()

  if cmdtype == ":" and cmdline == input then
    return output
  else
    return input
  end
end

function _G.cmd_alias(alias, cmd)
  vim.api.nvim_command(
    "cabbrev <expr> " .. alias .. " " .. "v:lua.abbreviate_or_noop('" .. alias .. "', '" .. cmd .. "')"
  )
end

-- @commands
-- run eslint automatically on certain filetypes
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*.{js,ts,jsx,tsx}",
  command = ":EslintFixAll",
})

cmd_alias("node", "! node %")
cmd_alias("tsnode", "! ts-node %")

-- custom user commands
local user_cmd = vim.api.nvim_create_user_command

user_cmd("CopyCurrentPath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

user_cmd("Files", telescope.find_files, {})
user_cmd("Commands", telescope.commands, {})
user_cmd("GitStatusFiles", telescope.git_status, {})
user_cmd("Buffers", telescope.buffers, {})
user_cmd("Diagnostics", telescope.diagnostics, {})
user_cmd("OldFiles", telescope.oldfiles, {})

-- @keymaps
local keyset = vim.keymap.set

-- remove highlight
keyset("n", "<Esc><Esc>", ":noh<cr>")

-- navigate fast between paragraphs
keyset("n", "<down>", "}")
keyset("n", "<up>", "{")

-- quit
keyset("n", "<leader>q", ":bd<cr>")

-- save
keyset("n", "<leader>w", ":w<cr>")

-- copy current buffer absolute path into clipboard
keyset("n", "<leader>y", ":CopyCurrentPath<cr>")

-- fast search
keyset("n", "<C-space>", "/")

-- file explorer
keyset("n", "<leader>-", ":Explore<cr>")

-- replace word under cursor
keyset("n", "<C-r>", ":%s#<c-r><c-w>##g<left><left>")
keyset("v", "<C-r>", ":s#<c-r><c-w>##g<left><left>")

-- diagnostic
keyset("n", "<leader>d", vim.diagnostic.open_float)
keyset("n", "[d", vim.diagnostic.goto_prev)
keyset("n", "]d", vim.diagnostic.goto_next)

-- ripgrep
keyset("n", "<leader>rg", ":Rg<space>")

-- commentary
keyset("n", "<C-/>", ":Commentary<cr>")
keyset("v", "<C-/>", ":Commentary<cr>")

-- vim-test
keyset("n", "<leader>tn", ":TestNearest<cr>", { silent = true })
keyset("n", "<leader>tf", ":TestFile<cr>", { silent = true })
keyset("n", "<leader>ts", ":TestSuite<cr>", { silent = true })
keyset("n", "<leader>tl", ":TestLast<cr>", { silent = true })
keyset("n", "<leader>tv", ":TestVisit<cr>", { silent = true })

-- packer
keyset("n", "<leader>pi", ":PackerInstall<cr>")
keyset("n", "<leader>pu", ":PackerUpdate<cr>")
keyset("n", "<leader>pc", ":PackerClean<cr>")

-- fugitive
keyset("n", "<leader>gd", ":Gdiff<cr>")

-- easymotion
keyset("n", ";", "<Plug>(easymotion-overwin-f)")

-- telescope
keyset("n", "<C-f>", telescope.find_files, { desc = "[F]ind [F]iles" })
keyset("n", "<C-p>", telescope.commands, { desc = "[F]ind [C]ommands" })
keyset("n", "<leader>fb", telescope.buffers, { desc = "[F]ind [B]uffers" })
keyset("n", "<leader>fd", telescope.diagnostics, { desc = "[F]ind [D]iagnostics" })
keyset("n", "<leader>ff", telescope.git_status, { desc = "[F]ind [F]iles Git Status" })
keyset("n", "<leader>fg", telescope.live_grep, { desc = "[F]ind [G]rep" })
keyset("n", "<leader>fh", telescope.oldfiles, { desc = "[F]ind [H]istory" })
keyset("n", "<leader>fw", telescope.grep_string, { desc = "[F]ind [W]ord" })

-- harpoon
keyset("n", "<leader>m", require("harpoon.mark").add_file)
keyset("n", "<leader>fm", ":Telescope harpoon marks<cr>")

-- lsp - set lsp mappings in callback
function SetCustomLspMappings(bufnr)
  keyset("n", "gd", ":Glance definitions<cr>", { desc = "[G]oto [D]efinition" })
  keyset("n", "gI", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
  keyset("n", "<leader>D", ":Glance type_definitions<cr>", { desc = "Type [D]efinition" })
  keyset("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
  keyset("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
  keyset("n", "<leader>f", vim.lsp.buf.format, { desc = "[F]ormat current buffer" })

  keyset("n", "gr", ":Glance references<cr>", { desc = "[G]oto [R]eferences" })
  keyset("n", "<leader>ds", telescope.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
  keyset("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = "Format current buffer with LSP" })
end
