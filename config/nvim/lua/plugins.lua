--------------------------------------------------------------------------------
-- Setup Packer
--------------------------------------------------------------------------------
local fn = vim.fn
vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

vim.cmd 'packadd packer.nvim'

require('packer').init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
    prompt_border = "single"
  },
  git = {
    clone_timeout = 600 -- Timeout, in seconds, for git clones
  },
  auto_clean = true,
  compile_on_sync = true,
  auto_reload_compiled = true
}

--------------------------------------------------------------------------------
-- Install Plugins
--------------------------------------------------------------------------------
require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim', event = "VimEnter" }
  use 'svermeulen/vimpeccable'

  use { 'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts = require('nvim-treesitter.install')
      ts.update({ with_sync = true })
      ts.compilers = { "gcc-12" }
    end,
  }

  -- Probably not needed because of treesitter. Also causes issues with ftdetect
  -- If going to use, make sure to add:
  -- `vim.g.polyglot_disabled = { 'ftdetect' }`
  -- to your `init.lua` file
  -- use { 'sheerun/vim-polyglot' }

  use { 'ellisonleao/gruvbox.nvim' }
  use 'folke/tokyonight.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('telescope').setup()
    end
  }

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "jose-elias-alvarez/typescript.nvim" -- Better LSP config for typescript
  }

  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        on_attach = require("lsp-format").on_attach,
        sources = {
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.code_actions.refactoring,

          null_ls.builtins.diagnostics.eslint_d,

          null_ls.builtins.formatting.prettierd
        }
      })
    end
  }
  -- use {
  --   "ray-x/lsp_signature.nvim",
  --   config = function()
  --     require('lsp_signature').setup({
  --       select_signature_key = "<C-n>",
  --       toggle_key = "<C-k>",
  --       floating_window = false
  --     })
  --   end
  -- }

  use "lukas-reineke/lsp-format.nvim"
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- Too slow on big files due to requiring treesitter to parse the entire file
  -- use { "lukas-reineke/indent-blankline.nvim", config = function()
  --   require('indent_blankline').setup(
  --     {
  --       char = " ",
  --       space_char_blankline = " ",
  --       context_char = "│",
  --       show_current_context = true,
  --       show_current_context_start = true,
  --     }
  --   )
  -- end }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })

  use { 'mrshmllow/document-color.nvim', config = function()
    require("document-color").setup {
      -- Default options
      mode = "background", -- "background" | "foreground" | "single"
    }
  end
  }

  -- Code outline
  use { 'simrat39/symbols-outline.nvim', config = function()
    require("symbols-outline").setup()
  end
  }

  use({
    "dnlhc/glance.nvim",
    config = function()
      require('glance').setup({
        -- your configuration
      })
    end,
  })

  use {
    'tanvirtin/vgit.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('vgit').setup({
        keymaps = {
          ['n [c'] = 'hunk_up',
          ['n ]c'] = 'hunk_down',
          ['n <leader>gs'] = 'buffer_hunk_stage',
          ['n <leader>gr'] = 'buffer_hunk_reset',
          ['n <leader>gp'] = 'buffer_hunk_preview',
          ['n <leader>gb'] = 'buffer_blame_preview',
          ['n <leader>gf'] = 'buffer_diff_preview',
          ['n <leader>gh'] = 'buffer_history_preview',
          ['n <leader>gu'] = 'buffer_reset',
          ['n <leader>gg'] = 'buffer_gutter_blame_preview',
          ['n <leader>glu'] = 'project_hunks_preview',
          ['n <leader>gls'] = 'project_hunks_staged_preview',
          ['n <leader>gd'] = 'project_diff_preview',
          ['n <leader>gq'] = 'project_hunks_qf',
          ['n <leader>gx'] = 'toggle_diff_preference',
        },
      })
    end
  }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim', config = function()
    require("neogit").setup()
  end
  }

  use {
    'goolord/alpha-nvim',
    config = function()
      require 'alpha'.setup(require 'alpha.themes.startify'.config)
    end
  }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  }

  use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup {
        options = {
          numbers = "ordinal",
          diagnostics = "nvim_lsp"
        }
      }
    end
  }

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use 'wakatime/vim-wakatime'
  use {
    "sitiom/nvim-numbertoggle",
  }
  use {
    'jghauser/mkdir.nvim'
  }
  use { 'cappyzawa/trim.nvim',
    config = function()
      require('trim').setup()
    end
  }
  use { 'ethanholz/nvim-lastplace',
    config = function()
      require('nvim-lastplace').setup()
    end
  }

  -- use 'windwp/nvim-ts-autotag'
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    "nvim-neorg/neorg",
    run = ":Neorg sync-parsers",
    config = function()
      require('neorg').setup {
        load = {
          ["core.defaults"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                work = "~/notes/work",
              },
              autochdir = false,
              default_workspace = "work",
            }
          },
          ["core.concealer"] = {},
          ["core.journal"] = {},
          ["core.qol.toc"] = {},
          ["core.presenter"] = {
            config = {
              zen_mode = "zen-mode",
            },
          },
          ["core.integrations.telescope"] = {},
          ["core.export"] = {
            config = {}
          },
          ["core.export.markdown"] = {
            config = {}
          },
        }
      }
    end,
    requires = { "nvim-lua/plenary.nvim",
      "nvim-neorg/neorg-telescope",
    }
  }

  -- install without yarn or npm
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" }
  })

  -- use({ "iamcco/markdown-preview.nvim",
  --   run = "cd app && npm install",
  --   setup = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --   end,
  --   ft = { "markdown" }, })

  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  }

  --------------------------------------------------------------------------------
  -- Buffers
  --------------------------------------------------------------------------------
  use { 'kazhala/close-buffers.nvim',
    config = function()
      require("close_buffers").setup()
    end
  }

  --------------------------------------------------------------------------------
  -- Setup Testing
  --------------------------------------------------------------------------------
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      'haydenmeade/neotest-jest',
      "rouge8/neotest-rust"
    }
  }

  use({
    "andythigpen/nvim-coverage",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("coverage").setup()
    end,
  })

  use "rgroli/other.nvim"


  --------------------------------------------------------------------------------
  -- Running commands
  --------------------------------------------------------------------------------
  use {
    'stevearc/overseer.nvim',
    requires = 'stevearc/dressing.nvim',
    config = function() require('overseer').setup() end
  }

  use 'lervag/vimtex'

  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
      require('refactoring').setup({})
    end
  }

  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require "octo".setup()
    end
  }

  use {
    'stevearc/profile.nvim'
  }

  use {
    'michaelb/sniprun',
    requires = {
      'rcarriga/nvim-notify'
    },
    run = 'sh ./install.sh',
    config = function()
      require 'sniprun'.setup({
        selected_interpreters = { "JS_TS_deno" },
        repl_enable = { "JS_TS_deno" },
        interpreter_options = {
          JS_TS_deno = {
            use_on_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
          },
        },
        display = {
          "VirtualText",
          "Classic",
          "NvimNotify",
        },
      })
    end
  }

  -- autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'davidsierradz/cmp-conventionalcommits' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-path' },
      { 'petertriho/cmp-git' },
      -- { 'hrsh7th/cmp-vsnip' },
    }
  }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

require("other-nvim").setup({
  mappings = {
    {
      pattern = "(.*)/(.*).test.ts$",
      target = "%1/%2.ts",
      context = "component"
    },
    {
      pattern = "(.*)/(.*).ts$",
      target = "%1/\\(%2.test.ts\\|%2.spec.ts\\)",
      context = "test"
    }
  }
})

require('neotest').setup({
  adapters = {
    require("neotest-rust"),
    require('neotest-jest')({
      jestCommand = "yarn test --coverage=true",
      jestConfigFile = "jest.config.ts",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  },
  consumers = {
    overseer = require("neotest.consumers.overseer"),
  },
  quickfix = {
    open = false
  }
})

require "nvim-tree".setup {
  hijack_netrw = true,
  view = {
    side = "right",
  }
}
require("mason").setup {
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls" },
}


require 'nvim-treesitter.configs'.setup {
  ensure_installed = { 'rust', 'typescript', 'html', 'javascript', 'css', 'norg', 'prisma', 'graphql' },
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(lang, bufnr) -- Disable in large C++ buffers
      return vim.api.nvim_buf_line_count(bufnr) > 5000
    end,
  },
  autotag = {
    enable = true,
    filetypes = {
      'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx',
      'rescript',
      'xml',
      'php',
      'markdown',
      'glimmer', 'handlebars', 'hbs', 'liquid',
      'graphql'
    }
  }
}

local lspconfig = require('lspconfig')
require("lsp-format").setup {
  typescript = {
    exclude = { "tsserver" },
    tab_width = function()
      return vim.opt.shiftwidth:get()
    end,
  },
  yaml = { tab_width = 2 },
  markdown = {
    exclude = { "remark_ls" },
  }
}

local on_attach = function(client, bufnr)
  require "lsp-format".on_attach(client)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)

  if client.server_capabilities.colorProvider then
    -- Attach document colour support
    require("document-color").buf_attach(bufnr)
  end
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- You are now capable!
capabilities.textDocument.colorProvider = {
  dynamicRegistration = true
}

local vim = vim
local cmp = require 'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs( -4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  },
    { { name = 'path' } })
})

-- Set configuration for specific filetype.
cmp.setup.filetype({ 'gitcommit', 'NeogitCommitMessage' }, {
  sources = cmp.config.sources(
    { { name = 'git' } },
    { { name = 'conventionalcommits' } },
    { { name = 'buffer' } }
  )
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  ["theme_check"] = function()
    lspconfig.theme_check.setup {
      root_dir = function()
        return vim.loop.cwd()
      end,
    }
  end
}

-- lspconfig['efm'].setup {
--   on_attach = require("lsp-format").on_attach,
--   init_options = { documentFormatting = true },
--   settings = {
--     languages = {
--       javascript = { prettier },
--       typescript = { prettier },
--       typescriptreact = { prettier },
--       yaml = { prettier },
--       markdown = { prettier },
--     },
--   },
-- }
-- Use better typescript config
require("typescript").setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  server = {
    on_attach = on_attach
  },
})

require('lualine').setup({
  sections = {
    lualine_x = { "overseer" },
  },
})

-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")

-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
  "v",
  "<leader>rr",
  "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  { noremap = true }
)
