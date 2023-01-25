-- @variables
local user_cmd = vim.api.nvim_create_user_command
local keyset = vim.keymap.set
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
  { "junegunn/gv.vim", event = "VeryLazy" },
  -- File explorer plugins
  { "tpope/vim-vinegar", event = "VeryLazy" },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<C-f>", ":Telescope find_files<cr>", desc = "Find files"  },
      { "<C-p>", ":Telescope commands<cr>", desc = "Commands" },
      { "<C-e>", ":Telescope grep_string<cr>", desc = "Grep String" },
      { "<leader>fb", ":Telescope buffers<cr>", desc = "[F]ind [B]uffers" },
      { "<leader>fd", ":Telescope diagnostics<cr>",  desc = "[F]ind [D]iagnostics" },
      { "<leader>ff", ":Telescope git_status<cr>",  desc = "[F]ind [F]iles Git Status" },
      { "<leader>fh", ":Telescope oldfiles<cr>",  desc = "[F]ind [H]istory" },
      { "<leader>fg", ":Telescope live_grep<cr>",  desc = "[F]ind [G]rep" },
      { "<leader>fr", ":Telescope registers<cr>", desc = "[Find] [R]egisters" },
      { "<leader>fk", ":Telescope keymaps<cr>", desc = "[Find] [K]eymaps" },
      { "<leader>fm", ":Telescope marks<cr>",  desc = "[Find] [M]arks" },
    },
    dependencies = { { "nvim-lua/plenary.nvim" } },
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
  {
    "dnlhc/glance.nvim",
    config = true,
    keys = {
      { "gd", ":Glance definitions<cr>", desc = "Go to Definition" },
      { "gr", ":Glance references<cr>", desc = "Go to References" },
    },
  },
  -- Syntax plugins
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = "TSUpdate",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "bash",
          "json",
          "javascript",
          "typescript",
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
      -- Snippets
      { "rafamadriz/friendly-snippets", event = "VeryLazy" },
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
        keyset("n", "gI", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
        keyset("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
        keyset("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
        keyset("n", "<leader>f", vim.lsp.buf.format, { desc = "[F]ormat current buffer" })

        local telescope = require("telescope.builtin")
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
      end)

      lsp.nvim_workspace()
      lsp.setup()
    end,
  },
})

-- @options
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

function _G.abbreviate_or_noop(input, output)
  local cmdtype = vim.fn.getcmdtype()
  local cmdline = vim.fn.getcmdline()

  if cmdtype == ":" and cmdline == input then
    return output
  else
    return input
  end
end

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

-- @commands
function _G.cmd_alias(alias, cmd)
  vim.api.nvim_command(
    "cabbrev <expr> " .. alias .. " " .. "v:lua.abbreviate_or_noop('" .. alias .. "', '" .. cmd .. "')"
  )
end

cmd_alias("node", "! node %")
cmd_alias("tsnode", "! ts-node %")

-- @keymaps
-- black hole
keyset("n", "<leader>dd", '"_dd')
-- remove highlight
keyset("n", "<Esc><Esc>", ":noh<cr>")
-- navigate fast between paragraphs
keyset("n", "<down>", "}")
keyset("n", "<up>", "{")
-- quit
keyset("n", "<leader>q", ":bd<cr>")
-- reload current file
keyset("n", "<leader>r", ":e %<cr>")
-- save
keyset("n", "<leader>w", ":w<cr>")
-- fast search
keyset("n", "<C-space>", "/")
-- file explorer
keyset("n", "<leader>-", ":Explore<cr>")
-- replace word under cursor
keyset("n", "<C-n>", ":%s#<c-r><c-w>##g<left><left>")
keyset("v", "<C-n>", ":s#<c-r><c-w>##g<left><left>")
-- diagnostic
keyset("n", "<leader>d", vim.diagnostic.open_float)
keyset("n", "[d", vim.diagnostic.goto_prev)
keyset("n", "]d", vim.diagnostic.goto_next)

-- copy current buffer absolute path into clipboard
user_cmd("CopyCurrentPath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
keyset("n", "<leader>y", ":CopyCurrentPath<cr>")
