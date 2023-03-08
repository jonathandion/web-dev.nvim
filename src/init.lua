-- @variables
local user_cmd = vim.api.nvim_create_user_command
local map = vim.keymap.set
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- @plugins
require("lazy").setup({
  -- UI plugins
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
  },
  -- Text manipulation plugins
  { "tpope/vim-surround", event = "VeryLazy" },
  { "tpope/vim-repeat", event = "VeryLazy" },
  {
    "echasnovski/mini.comment",
    version = '*',
    event = "VeryLazy",
    config = function()
      require('mini.comment').setup()
    end
  },
  {
    "echasnovski/mini.pairs",
    version = '*',
    event = "VeryLazy",
    config = function()
      require('mini.pairs').setup()
    end
  },
  {
    "echasnovski/mini.ai",
    version = '*',
    event = "VeryLazy",
    config = function()
      require('mini.ai').setup()
    end
  },
  -- Utility plugins
  {
    "phaazon/hop.nvim",
    config = true,
    keys = {
      { ";", ":HopChar1<cr>" },
    },
  },
  -- Coding plugins
  {
    "janko-m/vim-test",
    keys = {
      { "<leader>tn", ":TestNearest<cr>" },
      { "<leader>tf", ":TestFile<cr>" },
    },
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
  },
  -- Git plugins
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gs", ":Git<cr>" },
      { "<leader>gd", ":Gdiff<cr>" }
    }
  },
  { "ruanyl/vim-gh-line", event = "VeryLazy" },
  {
    "junegunn/gv.vim",
    event = "VeryLazy",
    dependencies = {
      { "tpope/vim-fugitive", lazy = true }
    }
  },
  -- File explorer plugins
  { "tpope/vim-vinegar", event = "VeryLazy" },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<C-f>", ":Telescope find_files<cr>", desc = "Find files" },
      { "<C-p>", ":Telescope commands<cr>", desc = "Commands" },
      { "<C-e>", ":Telescope grep_string<cr>", desc = "Grep String" },
      { "<leader>fb", ":Telescope buffers<cr>", desc = "[F]ind [B]uffers" },
      { "<leader>fd", ":Telescope diagnostics<cr>", desc = "[F]ind [D]iagnostics" },
      { "<leader>ff", ":Telescope git_status<cr>", desc = "[F]ind [F]iles Git Status" },
      { "<leader>fh", ":Telescope oldfiles<cr>", desc = "[F]ind [H]istory" },
      { "<leader>fg", ":Telescope live_grep<cr>", desc = "[F]ind [G]rep" },
      { "<leader>fr", ":Telescope registers<cr>", desc = "[Find] [R]egisters" },
      { "<leader>fk", ":Telescope keymaps<cr>", desc = "[Find] [K]eymaps" },
      { "<leader>fm", ":Telescope marks<cr>", desc = "[Find] [M]arks" },
      { "gd", ":Telescope lsp_definitions<cr>", desc = "Go to Definition" },
      { "gr", ":Telescope lsp_references<cr>", desc = "Go to References" },
    },
    dependencies = { { "nvim-lua/plenary.nvim", lazy = true } },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = {
            ".git",
          },
        },
        pickers = {
          find_files = {
            follow = true,
            hidden = true,
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
    end,
  },
  -- Syntax plugins
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = "TSUpdate",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "html",
          "javascript",
          "typescript",
          "json",
          "vim",
          "lua",
          "bash",
          "markdown",
        },
        sync_install = false,
        auto_install = true,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
  -- LSP plugins
  {
    "VonHeikemen/lsp-zero.nvim",
    event = "VeryLazy",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig", event = "VeryLazy" },
      -- LSP servers manager
      { "williamboman/mason.nvim", config = true, event = "VeryLazy" },
      { "williamboman/mason-lspconfig.nvim", event = "VeryLazy" },
      -- Autocompletion
      { "hrsh7th/nvim-cmp", event = "VeryLazy" },
      { "hrsh7th/cmp-buffer", event = "VeryLazy" },
      { "hrsh7th/cmp-path", event = "VeryLazy" },
      { "hrsh7th/cmp-nvim-lsp", event = "VeryLazy" },
      { "hrsh7th/cmp-nvim-lua", event = "VeryLazy" },
      -- UI
      { "j-hui/fidget.nvim", config = true, event = "VeryLazy" },
    },
    config = function()
      -- Lsp
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
        "tailwindcss",
        "stylelint_lsp",
        "eslint",
        "marksman",
        "astro",

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
        map("n", "gI", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
        map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
        map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
        map("n", "<leader>f", vim.lsp.buf.format, { desc = "[F]ormat current buffer" })

        local telescope = require("telescope.builtin")
        map("n", "<leader>ds", telescope.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
        map("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          if vim.lsp.buf.format then
            vim.lsp.buf.format()
          elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
          end
        end, { desc = "Format current buffer with LSP" })
      end)

      lsp.nvim_workspace()
      lsp.setup()
    end,
  },
})

-- @options
local opt = vim.opt
opt.path = table.concat({ "**" }) -- Search in subdirectories
opt.background = "dark" -- Dark background
opt.backup = false -- Disable backup
opt.breakindent = true -- Wrap text with indent
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.guicursor = "" -- Fat cursor (old vim style)
opt.history = 500 -- History size
opt.hlsearch = true -- Highlight search
opt.ignorecase = true -- Ignore case
opt.incsearch = true -- Show search matches
opt.laststatus = 2 -- Always display the status line
opt.magic = true -- Regular expressions
opt.shiftwidth = 2 -- Size of an indent
opt.showmatch = true -- Show matching brackets
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smarttab = true -- Insert indents automatically
opt.smartindent = true -- Insert indents automatically
opt.so = 7 -- Minimum number of screen lines to keep above and below the cursor
opt.softtabstop = 0 -- Number of spaces tabs count for
opt.timeoutlen = 500 -- Time to wait for a mapped sequence to complete (in milliseconds)
opt.title = true -- Set the terminal title
opt.ttimeout = true -- Enable timeout for key mappings
opt.ttimeoutlen = 10 -- Time to wait for a mapped sequence to complete (in milliseconds)
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true -- Enable persistent undo
opt.updatetime = 250 -- Save swap file and trigger CursorHold
opt.wildmenu = true -- Enable command-line completion mode
opt.wildmode = "full" -- Command-line completion mode
opt.wrap = true -- Wrap long lines
opt.writebackup = false -- Disable backup
opt.spelllang = { "en" } -- Spell check english
opt.grepprg = "rg --vimgrep" -- Use ripgrep for grepping
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.iskeyword:append("-") -- Treat dash separated words as a word text object

vim.wo.number = true

-- Netrw config (file explorer)
vim.g.netrw_banner = 1
vim.g.netrw_liststyle = 4
vim.g.netrw_localrmdir = "rm -r"
vim.g.netrw_hide = 0

-- Custom file types
vim.filetype.add({
  extension = {
    eslintrc = "json",
    mdx = "markdown",
    prettierrc = "json",
    mjml = "html",
  },
  pattern = {
    [".*%.env.*"] = "sh",
  },
})

-- @auto-commands
-- Run Eslint automatically on certain filetypes
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*.{js,ts,jsx,tsx}",
  callback = function()
    if vim.fn.exists(":EslintFixAll") > 0 then
      -- @TODO we need to wait for eslint to finish and save the file
      vim.cmd("EslintFixAll")
      return
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- @commands
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

cmd_alias("node", "! node %")
cmd_alias("tsnode", "! ts-node %")
user_cmd("Styling", "! npx stylelint --fix %", {})

-- @keymaps
-- black hole
map("n", "<leader>dd", '"_dd')
-- remove highlight
map("n", "<Esc><Esc>", ":noh<cr>")
-- navigate fast between paragraphs
map("n", "<down>", "}")
map("n", "<up>", "{")
-- quit
map("n", "<leader>q", ":bd<cr>")
-- reload current buffer
map("n", "<leader>r", ":e %<cr>")
-- format buffer
map("n", "<leader>f", ":Format<cr>")
-- save
map("n", "<leader>w", ":w<cr>")
-- fast search
map("n", "<C-space>", "/")
-- file explorer
map("n", "<leader>-", ":Explore<cr>")
-- replace word under cursor
map("n", "<C-n>", ":%s#<c-r><c-w>##g<left><left>")
map("v", "<C-n>", ":s#<c-r><c-w>##g<left><left>")
-- diagnostic
map("n", "<leader>d", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)

-- copy current buffer absolute path into clipboard
user_cmd("CopyCurrentPath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
map("n", "<leader>y", ":CopyCurrentPath<cr>")
