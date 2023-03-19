require('settings')

vim.api.nvim_set_keymap('', '<leader><cr>', ':noh<cr>', { noremap = true, silent = true })
-----------------------------------
-- Install plugins with Lazy
-----------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- fuzzy search and pickers
  --"junegunn/fzf",
  --"junegunn/fzf.vim",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  -- LSP
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/nvim-cmp",
  "saadparwaiz1/cmp_luasnip",
  "L3MON4D3/LuaSnip",
  "folke/trouble.nvim",
  "seblj/nvim-echo-diagnostics",
  "rmagatti/goto-preview",
  "simrat39/rust-tools.nvim",
  "nvim-treesitter/nvim-treesitter",
  -- UI
  "folke/tokyonight.nvim",
  "rebelot/kanagawa.nvim",
  "folke/lsp-colors.nvim",
  "kyazdani42/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",
  "j-hui/fidget.nvim",
  "goolord/alpha-nvim",
  "folke/which-key.nvim",
  "akinsho/bufferline.nvim",
  "akinsho/toggleterm.nvim",
  "tpope/vim-fugitive",
  "lewis6991/gitsigns.nvim",
  "onsails/lspkind.nvim",
  'stevearc/dressing.nvim',
  'nvim-telescope/telescope-ui-select.nvim',
  'nvim-telescope/telescope-dap.nvim',
  -- Dev
  "chrisbra/csv.vim",
  "ahmedkhalf/project.nvim",
  "nvim-tree/nvim-tree.lua",
  "azabiong/vim-highlighter",
  "numToStr/Comment.nvim",
  "sindrets/diffview.nvim",
  "SmiteshP/nvim-navic",
  "simrat39/symbols-outline.nvim",
  "ray-x/lsp_signature.nvim",
  "dnlhc/glance.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "mfussenegger/nvim-dap",
  'rcarriga/nvim-dap-ui',
  'theHamsta/nvim-dap-virtual-text'
},
  {
    ui = {
      border = "single",
    }
  })

-----------------------------------
-- General plugin configurations
-- with vim commands
-----------------------------------

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Update more frequently for CursorHold
vim.opt.updatetime = 300

-- nvim-telescope/telescope-fzf-native.nvim
local actions = require("telescope.actions")
telescope = require('telescope')
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor {
      }
    }
  }
}
telescope.load_extension('fzf')
telescope.load_extension('projects')
telescope.load_extension("ui-select")
telescope.load_extension('dap')
vim.cmd [[
nnoremap <leader>fr <cmd>Telescope resume<cr>
nnoremap <C-P> <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep theme=ivy<cr>
nnoremap <leader>fb <cmd>Telescope buffers theme=ivy<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <C-H> <cmd>Telescope oldfiles<cr>
nnoremap <leader>fh <cmd>Telescope oldfiles<cr>
nnoremap <leader>fp <cmd>Telescope projects<cr>

augroup FugitiveBehavior
  autocmd!
  autocmd User FugitiveStageBlob setlocal readonly nomodifiable noswapfile
augroup END

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]


-----------------------------------
-- neovim/nvim-lspconfig
-- nvim-lua/kickstart.nvim
-----------------------------------
local navic = require("nvim-navic")
local nvim_lsp = require('lspconfig')
local lsp_signature = require('lsp_signature')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- skip buffers with special URI, e.g. fugitive://...
  if vim.api.nvim_buf_get_name(bufnr):match "^%a+://" then
    return
  end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- from https://github.com/neovim/nvim-lspconfig
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float({border="rounded"})<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({float={border="rounded"}})<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({float={border="rounded"}})<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format({async=true})<CR>', opts)
  buf_set_keymap('n', '<space>fw', '<cmd>Telescope lsp_dynamic_workspace_symbols theme=ivy<cr>', opts)
  buf_set_keymap('n', '<leader>fr', '<cmd>Telescope lsp_references theme=ivy<cr>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.server_capabilities.documentRangeFormattingProvider then
    buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight() require('echo-diagnostics').echo_line_diagnostic()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
    lsp_signature.on_attach({
      hint_prefix = " ",
    }, bufnr)
  end
end

-----------------------------------
-- hrsh7th/nvim-cmp
-- Add additional capabilities supported by nvim-cmp
-----------------------------------
--local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'pyright' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
    on_attach = on_attach
  }
end

-----------------------------------
-- nvim-dap-ui
-----------------------------------
vim.fn.sign_define('DapBreakpoint', {text='', texthl='DiagnosticError', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='DiagnosticWarn', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='', texthl='', linehl='DiagnosticInfo', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='DiagnosticHint', linehl='', numhl=''})

require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
  require 'dap_cfg'
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
require("nvim-dap-virtual-text").setup({
  virt_text_win_col = 120, highlight_changed_variables = true
}

)
-----------------------------------
-- rust-tools
-----------------------------------
local rt = require("rust-tools")

rt.setup({
  tools = {
    inlay_hints = {
      auto =true,
      highlight = "LineNr",
    },
  },
  server = {
    standalone = true,
    on_attach = function(client, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      -- Enable other mappings
      on_attach(client, bufnr)

    end,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          allFeatures = true,
          overrideCommand = {
            "cargo",
            "clippy",
            "--workspace",
            "--message-format=json",
            "--all-targets",
            "--all-features",
          },
        },
      },
    },
  },
   dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter(
        "/home/kting/.vscode-server/extensions/vadimcn.vscode-lldb-1.9.0/adapter/codelldb",
        "/home/kting/.vscode-server/extensions/vadimcn.vscode-lldb-1.9.0/lldb/lib/liblldb.so"
      )
    },
})

-----------------------------------
-- Configure nvim-cmp for completion
-- and signature hints
-----------------------------------
-- Set completeopt to have a better
-- completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
local lspkind = require('lspkind')
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs( -4)),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4)),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete()),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- they way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      }),
    }),
  },
})
vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(
      vim.lsp.handlers.hover,
      {
        border = "single"
      }
    )

vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(
      vim.lsp.handlers.signature_help,
      {
        border = "single"
      }
    )

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      {
        virtual_text = false,
      }
    )

local signs = { Error = "", Warn = "", Hint = "", Information = "" }
for type, icon in pairs(signs) do
  -- LspDiagnosticsSign for nvim 0.5.1
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-----------------------------------
-- nvim-teesitter
-----------------------------------
require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "javascript" }, -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-----------------------------------
-- Color schemes
-----------------------------------
vim.g.tokyonight_colors = { comment = "#8c8c8c", fg = "#fafaf4" }
-- vim.cmd[[colorscheme tokyonight]]
require('kanagawa').setup({
  undercurl = true,
  commentStyle = { italic = false },
  keywordStyle = { italic = false },
})
vim.cmd [[colorscheme kanagawa]]


-----------------------------------
-- Misc. plugin setup calls
-----------------------------------
require("trouble").setup {
  mode = "document_diagnostics"
}
require("which-key").setup {
  window = {
    border = "single", -- none, single, double, shadow
  }
}
require("lualine").setup {
  options = {
    theme = 'kanagawa'
  },
  sections = {
    lualine_b = { 'branch', 'diff', 'diagnostics', 
      {'filename' ,
        path = 1,
        symbols = {
          modified = '',      -- Text to show when the file is modified.
          readonly = '',
        }
      }
    },
    lualine_c = {
      {
        navic.get_location, cond = navic.is_available
      }
    }
  }
}
require("toggleterm").setup {}
require("bufferline").setup {}
require("gitsigns").setup {}
require('goto-preview').setup {
  default_mappings = true,
}
require("project_nvim").setup {
  manual_mode = false,
  patterns = { ".git", ".p4config", ".p4env", "Makefile", "package.json" }
}

require("nvim-tree").setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
})

local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1
  if not directory then
    return
  end
  -- change to the directory
  vim.cmd.cd(data.file)
  -- open the tree
  require("nvim-tree.api").tree.open()
end


vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

require('Comment').setup()
require('symbols-outline').setup()
require('fidget').setup {}
require('glance').setup({
  border = { enable = true }
})
require('alpha').setup(require 'alpha.themes.startify'.config)
require("indent_blankline").setup {
  -- for example, context is off by default, use this to turn it on
  enabled = false,
  show_current_context = true,
  show_current_context_start = true,
}

require("echo-diagnostics").setup {
  show_diagnostic_number = true,
  show_diagnostic_source = true,
}

require 'terminals'
