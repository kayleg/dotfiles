--------------------------------------------------------------------------------
-- Setup Lazy
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local result = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  vim.pretty_print(result)
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------------------
-- Install Plugins
--------------------------------------------------------------------------------
require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    }
  },
  { "svermeulen/vimpeccable" },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
    config = function()
      local ts = require("nvim-treesitter.install")
      -- ts.compilers = { "gcc-12" }
    end,
  },

  -- Probably not needed because of treesitter. Also causes issues with ftdetect
  -- If going to use, make sure to add:
  -- `vim.g.polyglot_disabled = { 'ftdetect' }`
  -- to your `init.lua` file
  -- use { 'sheerun/vim-polyglot' }

  -- { "ellisonleao/gruvbox.nvim", lazy = true },

  -- {
  --   "nvim-telescope/telescope.nvim",
  --   config = true,
  --   dependencies = { "nvim-lua/plenary.nvim" },
  -- },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
      { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
      { "<leader>fe",      function() Snacks.explorer() end,                                       desc = "File Explorer" },
      -- find
      { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
      { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
      { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
      { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
      -- git
      -- { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
      -- { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
      -- { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
      -- { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
      -- { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
      -- { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
      -- { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
      -- Grep
      { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
      { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
      { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
      { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
      { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
      { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
      { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
      { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
      { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
      { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
      { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
      { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
      { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
      { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
      { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
      { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
      { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
      { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
      { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
      { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
      { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
      { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
      -- LSP
      { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
      { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
      { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
      { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
      { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
      { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
      { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
      -- Other
      { "<leader>z",       function() Snacks.zen() end,                                            desc = "Toggle Zen Mode" },
      { "<leader>Z",       function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
      { "<leader>.",       function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
      { "<leader>S",       function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
      { "<leader>n",       function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
      { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
      { "<leader>cR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
      { "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",               mode = { "n", "v" } },
      { "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "Lazygit" },
      { "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
      { "<c-/>",           function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
      { "<c-_>",           function() Snacks.terminal() end,                                       desc = "which_key_ignore" },
      { "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",           mode = { "n", "t" } },
      { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",           mode = { "n", "t" } },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      }
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
            "<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },

  {
    "mason-org/mason.nvim",
    version = "1.*.*",
    opts = {
      automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
      ui = {
        icons = {
          server_installed = "✓",
          server_pending = "➜",
          server_uninstalled = "✗",
        },
      },
    },
    dependencies = {
      {
        "mason-org/mason-lspconfig.nvim",
        version = "1.*.*",
        config = function()
          local lspconfig = require("lspconfig")
          local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
          local on_attach = function(client, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
            -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
            vim.keymap.set("n", "<space>wl", function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts)
            vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
            vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
            vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)

            if client.server_capabilities.colorProvider then
              -- Attach document colour support
              require("document-color").buf_attach(bufnr)
            end
          end

          -- local capabilities = vim.lsp.protocol.make_client_capabilities()
          local capabilities = require("cmp_nvim_lsp").default_capabilities()

          -- You are now capable!
          capabilities.textDocument.colorProvider = {
            dynamicRegistration = true,
          }

          local vim = vim
          require("mason-lspconfig").setup_handlers({
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
              lspconfig.theme_check.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                root_dir = function()
                  return vim.loop.cwd()
                end,
              })
            end,

            ['cssls'] = function()
              local custom_capabilities = require("cmp_nvim_lsp").default_capabilities()
              custom_capabilities.textDocument.completion.completionItem.snippetSupport = true
              lspconfig.cssls.setup({
                on_attach = on_attach,
                capabilities = custom_capabilities,
                settings = {
                  css = {
                    validate = true,
                    lint = {
                      unknownAtRules = 'ignore'
                    },
                  },
                  less = {
                    validate = true,
                    lint = {
                      unknownAtRules = 'ignore'
                    },
                  },
                  scss = {
                    validate = true,
                    lint = {
                      unknownAtRules = 'ignore'
                    },
                  }
                }
              })
            end



            -- ["ruby_ls"] = function()
            -- 	lspconfig.ruby_ls.setup({
            -- 		cmd = { "bundle", "exec", "ruby-lsp" },
            -- 		on_attach = on_attach,
            -- 		capabilities = capabilities,
            -- 		enabledfeatures = {
            -- 			"codeactions",
            -- 			"diagnostics",
            -- 			"documenthighlights",
            -- 			"documentsymbols",
            -- 			"formatting",
            -- 			"inlayhint",
            -- 			"foldingRanges",
            -- 			"selectionRanges",
            -- 			"semanticHighlighting",
            -- 			"hover",
            -- 		},
            -- 	})
            -- end,
          })
        end,
        opts = {
          ensure_installed = { "lua_ls" },
        }
      },
      "neovim/nvim-lspconfig",
    }
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        publish_diagnostic_on = 'change',
        expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" }
      }
    }
  },

  {
    "dmmulroy/tsc.nvim",
    lazy = true,
    ft = { 'typescript', 'typescriptreact' },
    opts = {
      use_trouble_qflist = true,
    }
  },

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = {
      lsp = {
        capabilities = {
          textDocument = { formatting = { dynamicRegistration = false } },
        },
      }
    }
  },


  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = true
  },

  {
    "folke/trouble.nvim",
    config = true,
    dependencies = "nvim-tree/nvim-web-devicons",
  },

  {
    "elentok/format-on-save.nvim",
    config = function()
      local format_on_save = require("format-on-save")
      local formatters = require("format-on-save.formatters")

      format_on_save.setup({
        exclude_path_patterns = {
          "/node_modules/",
          ".local/share/nvim/lazy",
        },
        formatter_by_ft = {
          css = formatters.lsp,
          html = formatters.lsp,
          java = formatters.lsp,
          javascript = formatters.prettierd,
          json = formatters.lsp,
          liquid = formatters.prettierd,
          lua = formatters.lsp,
          markdown = formatters.prettierd,
          openscad = formatters.lsp,
          python = formatters.black,
          ruby = formatters.lsp,
          rust = formatters.lsp,
          scad = formatters.lsp,
          scss = formatters.lsp,
          sh = formatters.shfmt,
          terraform = formatters.lsp,
          typescript = formatters.prettierd,
          typescriptreact = formatters.prettierd,
          yaml = formatters.lsp,
          go = formatters.lsp,
          gomod = formatters.lsp,
          dart = formatters.lsp,
          eruby = {
            formatters.if_file_exists({
              pattern = ".prettierrc",
              formatter = formatters.prettierd,
            }),
            formatters.shell({ cmd = { 'erb-format', '--stdin' } }),
          }
        },

        -- Optional: fallback formatter to use when no formatters match the current filetype
        fallback_formatter = {
          formatters.remove_trailing_whitespace,
          formatters.remove_trailing_newlines,
        },
      })
    end,
  },

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

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('lualine').setup({

        sections = {
          lualine_x = { "overseer" },
          lualine_y = { "progress", { require('plugins.codecompanion.lualine') } },
        },
      })
    end
  },

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

  {
    "numToStr/Comment.nvim",
    config = true
  },

  {
    "kylechui/nvim-surround",
    config = true
  },

  -- Code outline
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>so", "<cmd>Outline<CR>",      desc = "Toggle outline" },
      { "<leader>fs", "<cmd>OutlineFocus<CR>", desc = "Toggle Focus between outline and code" },
    },
    opts = {
      -- Your setup opts here
    },
  },
  {
    "mrshmllow/document-color.nvim",
    opts = { mode = "background" }
  },

  {
    "dnlhc/glance.nvim",
    config = true
  },

  {
    "tanvirtin/vgit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      keymaps = {
        ["n [c"] = "hunk_up",
        ["n ]c"] = "hunk_down",
        ["n <leader>ghs"] = "buffer_hunk_stage",
        ["n <leader>ghr"] = "buffer_hunk_reset",
        ["n <leader>ghp"] = "buffer_hunk_preview",
        ["n <leader>gb"] = "buffer_blame_preview",
        ["n <leader>gf"] = "buffer_diff_preview",
        ["n <leader>gh"] = "buffer_history_preview",
        ["n <leader>gu"] = "buffer_reset",
        ["n <leader>gg"] = "buffer_gutter_blame_preview",
        ["n <leader>glu"] = "project_hunks_preview",
        ["n <leader>gls"] = "project_hunks_staged_preview",
        ["n <leader>gd"] = "project_diff_preview",
        ["n <leader>gq"] = "project_hunks_qf",
        ["n <leader>gx"] = "toggle_diff_preference",
      },
    }
  },
  {
    "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim", config = true
  },

  {
    "NeogitOrg/neogit",
    config = true,
    dependencies = "nvim-lua/plenary.nvim",
  },

  {
    "ruifm/gitlinker.nvim",
    lazy = true,
    keys = "<leader>gy",
    config = true,
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- {
  --   "goolord/alpha-nvim",
  --   config = function()
  --     require("alpha").setup(require("alpha.themes.startify").config)
  --   end,
  -- },
  -- {
  --   'nvimdev/dashboard-nvim',
  --   event = 'VimEnter',
  --   dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  --   opts = {
  --     theme = 'hyper',
  --     config = {
  --       week_header = {
  --         enable = true,
  --       },
  --       shortcut = {
  --         { desc = ' New File', group = '@property', action = 'enew', key = 'n' },
  --         {
  --           icon = ' ',
  --           icon_hl = '@variable',
  --           desc = 'Files',
  --           group = 'Label',
  --           action = 'Telescope find_files',
  --           key = 'f',
  --         },
  --       },
  --     },
  --   }
  -- },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    opts = {
      hijack_netrw = true,
      view = {
        side = "right",
      },
    }
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
      },
    }
  },

  {
    "windwp/nvim-autopairs",
    config = true
  },

  {
    "wakatime/vim-wakatime"
  },
  {
    "sitiom/nvim-numbertoggle",
  },
  {
    "jghauser/mkdir.nvim",
  },
  {
    "cappyzawa/trim.nvim",
    config = true
  },
  {
    "ethanholz/nvim-lastplace",
    config = true
  },

  -- use 'windwp/nvim-ts-autotag'
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = true
  },

  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true,   -- This automatically runs `require("luarocks-nvim").setup()`
  },

  {
    "nvim-neorg/neorg",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              work = "~/notes/work",
            },
            autochdir = false,
            default_workspace = "work",
          },
        },
        ["core.concealer"] = {},
        ["core.journal"] = {},
        ["core.qol.toc"] = {},
        ["core.summary"] = { config = { strategy = "default" } },
        ["core.presenter"] = {
          config = {
            zen_mode = "zen-mode",
          },
        },
        -- ["core.integrations.telescope"] = {},
        ["core.export"] = {
          config = {},
        },
        ["core.export.markdown"] = {
          config = {},
        },
      },
    },
    dependencies = { "nvim-lua/plenary.nvim",
      {
        "juniorsundar/neorg-extras",
      },
      "luarocks.nvim" },
  },

  -- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- use({ "iamcco/markdown-preview.nvim",
  --   run = "cd app && npm install",
  --   setup = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --   end,
  --   ft = { "markdown" }, })

  {
    "glacambre/firenvim",
    build = function()
      vim.fn["firenvim#install"](0)
    end,
  },

  --------------------------------------------------------------------------------
  -- AI / CoPilot
  --------------------------------------------------------------------------------
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = true
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- comment the following line to ensure hub will be ready at the earliest
    cmd = "MCPHub",                          -- lazy load by default
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = {
      auto_approve = true,
      extensions = {
        codecompanion = {
          -- Show the mcp tool result in the chat buffer
          show_result_in_chat = true,
          -- Make chat #variables from MCP server resources
          make_vars = true,
        }
      }
    }
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",                                                                    -- Optional: For using slash commands and variables in the chat buffer
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }, -- Optional: For prettier markdown rendering
      { "stevearc/dressing.nvim",                    opts = {} },                            -- Optional: Improves `vim.ui.select`
      { 'echasnovski/mini.diff',                     version = '*' },
      {
        "Davidyz/VectorCode",
        version = "*",                     -- optional, depending on whether you're on nightly or release
        build = "pipx upgrade vectorcode", -- optional but recommended if you set `version = "*"`
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "VectorCode"
      },
    },
    cmd = { "CodeCompanion", "CodeCompanionToggle", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      { "<leader>cc", "<cmd>CodeCompanionActions<cr>", desc = "Toggle Code Companion" },
    },
    opts = function()
      return {
        adapters = {
          -- copilot = function()
          --   return require("codecompanion.adapters").extend("copilot", {
          --     schema = {
          --       model = {
          --         default = "gemini-2.5-pro"
          --       },
          --     }
          --   })
          -- end,
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "cmd:security find-generic-password -w -a Anthropic",
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = "anthropic",
            slash_commands = {
              ["file"] = {
                opts = {
                  provider = "snacks",
                },
              },
              ["buffer"] = {
                opts = {
                  provider = "snacks",
                },
              },
              ["codebase"] = require("vectorcode.integrations").codecompanion.chat.make_slash_command(),
            },
            tools = {
              ["mcp"] = {
                -- Prevent mcphub from loading before needed
                callback = function()
                  return require("mcphub.extensions.codecompanion")
                end,
                description = "Call tools and resources from the MCP Servers",
              },
              ["vectorcode"] = {
                description = "Run VectorCode to retrieve the project context.",
                callback = function()
                  return require("vectorcode.integrations").codecompanion.chat.make_tool()
                end,
              }
            },
            -- keymaps = {
            --   send = {
            --     callback = function(chat)
            --       vim.cmd("stopinsert")
            --       chat:add_buf_message({ role = "llm", content = "" })
            --       chat:submit()
            --     end,
            --     index = 1,
            --     description = "Send",
            --   },
            -- }
          },
        },
        prompt_library = {
          ['Generate a Commit Message'] = {
            opts = {
              adapter = {
                name = "copilot"
              }
            },
          },
        },
        display = {
          diff = {
            enabled = true,
            close_chat_at = 240,    -- Close an open chat buffer if the total columns of your display are less than...
            layout = "vertical",    -- vertical|horizontal split for default provider
            opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
            provider = "mini_diff", -- default|mini_diff
          },
        },
      }
    end,

    -- init = function()
    --   require("plugins.codecompanion.spinner"):init()
    -- end,
  },
  {
    "echasnovski/mini.diff", -- Inline and better diff over the default
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
  --------------------------------------------------------------------------------
  -- Buffers
  --------------------------------------------------------------------------------
  {
    "kazhala/close-buffers.nvim",
    config = true
  },

  --------------------------------------------------------------------------------
  -- Setup Testing
  --------------------------------------------------------------------------------
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
      "rouge8/neotest-rust",
      "zidhuss/neotest-minitest",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      local jestCommand = 'yarn test';
      if vim.fn.filereadable(vim.fn.getcwd() .. "package-lock.json") then
        jestCommand = 'npm test --'
      end
      require('neotest').setup({
        adapters = {
          require("neotest-rust"),
          require("neotest-jest")({
            jestCommand = jestCommand,
            jestConfigFile = "jest.config.ts",
            env = { CI = false },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
          require("neotest-minitest"),
        },
        consumers = {
          overseer = require("neotest.consumers.overseer"),
        },
        quickfix = {
          open = false,
        },
      })
    end
  },

  {
    "andythigpen/nvim-coverage",
    dependencies = "nvim-lua/plenary.nvim",
    config = true
  },

  {
    "rgroli/other.nvim",
    config = function()
      require('other-nvim').setup({
        mappings = {
          "rails",
          {
            pattern = "(.*)/(.*).test.ts$",
            target = "%1/%2.ts",
            context = "component",
          },
          {
            pattern = "(.*)/.*.ts$",
            target = "%1/\\(*.test.ts\\|*.spec.ts\\)",
            context = "test",
          },
        },
      })
    end,
  },

  --------------------------------------------------------------------------------
  -- Running commands
  --------------------------------------------------------------------------------
  {
    "stevearc/overseer.nvim",
    dependencies = "stevearc/dressing.nvim",
    config = function()
      require("overseer").setup({
        actions = {
          ["clear output"] = {
            desc = "Clear the output",
            run = function(task)
              vim.api.nvim_chan_send(task.strategy.term_id, "\027[H\027[2J")
            end,
          },
        },
        task_list = {
          bindings = {
            ['<C-c>'] = '<CMD>OverseerQuickAction clear output<CR>',
          }
        }
      })
      require('overseer').add_template_hook({}, function(task_defn)
        task_defn.strategy = { "jobstart", preserver_output = false, use_terminal = true }
      end
      )
    end,
  },

  {
    "lervag/vimtex",
    lazy = true,
    ft = "tex"
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = true
  },

  {
    "pwntester/octo.nvim",
    lazy = true,
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = {
      default_to_projects_v2 = true,
      picker = "snacks"
    }
  },

  -- Profiler when debugging startup
  -- {
  --   "stevearc/profile.nvim",
  -- },

  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")
      notify.setup({
        stages = "static",
      })
      vim.notify = notify
      local banned_messages = { "No information available" }
      vim.notify = function(msg, ...)
        for _, banned in ipairs(banned_messages) do
          if msg == banned then
            return
          end
        end
        return notify(msg, ...)
      end
    end,
  },

  {
    "michaelb/sniprun",
    lazy = true,
    cmd = { "SnipRun", "SnipInfo" },
    dependencies = {
      "rcarriga/nvim-notify",
    },
    build = "sh ./install.sh",
    opts = {
      selected_interpreters = { "JS_TS_deno" },
      repl_enable = { "JS_TS_deno" },
      interpreter_options = {
        JS_TS_deno = {
          use_on_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        },
      },
      display = {
        "VirtualText",
        "Classic",
        "NvimNotify",
      },
    }
  },

  { "mistricky/codesnap.nvim", build = "make" },

  {
    "tpope/vim-abolish"
  },

  -- autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "davidsierradz/cmp-conventionalcommits" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-path" },
      { "petertriho/cmp-git" },
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/vim-vsnip' }
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
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
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = 'vsnip' }, -- For vsnip users.
          -- { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = "buffer" },
        }, { { name = "path" } }),
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype({ "gitcommit", "NeogitCommitMessage" }, {
        sources = cmp.config.sources({ { name = "git" } }, { { name = "conventionalcommits" } }, { { name = "buffer" } }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end
  },

  -- navigation
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          jump_labels = true
        }
      }
    }
  },

  {
    "yorickpeterse/nvim-window",
    config = true
  },

  {
    "shortcuts/no-neck-pain.nvim",
    lazy = true,
    cmd = "NoNeckPain",
    version = "*",
    opts = {
      width = 130
    }
  },

  {
    "https://github.com/pimalaya/himalaya-vim",
    lazy = true,
    cmd = "Himalaya"
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    opts = {
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      {
        's1n7ax/nvim-window-picker',
        version = '2.*',
        opts = {
          hint = 'floating-big-letter',
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { 'neo-tree', "neo-tree-popup", "notify" },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { 'terminal', "quickfix" },
            },
          },
        }
      },
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },

  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      animate = {
        enabled = false
      },
      close_when_all_hidden = false,
      -- bottom = {
      --   -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
      --   {
      --     ft = "toggleterm",
      --     size = { height = 0.4 },
      --     -- exclude floating windows
      --     filter = function(buf, win)
      --       return vim.api.nvim_win_get_config(win).relative == ""
      --     end,
      --   },
      --   {
      --     ft = "lazyterm",
      --     title = "LazyTerm",
      --     size = { height = 0.4 },
      --     filter = function(buf)
      --       return not vim.b[buf].lazyterm_cmd
      --     end,
      --   },
      --   "Trouble",
      --   { ft = "qf", title = "QuickFix" },
      --   {
      --     ft = "help",
      --     size = { height = 20 },
      --     -- only show help buffers
      --     filter = function(buf)
      --       return vim.bo[buf].buftype == "help"
      --     end,
      --   },
      --   { ft = "spectre_panel", size = { height = 0.4 } },
      -- },
      right = {
        -- Neo-tree filesystem always takes half the screen height
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          size = { height = 0.5 },
        },
        {
          title = "Neo-Tree Git",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "git_status"
          end,
          pinned = true,
          open = "Neotree position=right git_status",
        },
        {
          title = "Neo-Tree Buffers",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "buffers"
          end,
          pinned = true,
          open = "Neotree position=top buffers",
        },
        {
          ft = "Outline",
          pinned = true,
          open = "SymbolsOutlineOpen",
        },
        -- any other neo-tree windows
        "neo-tree",
      },
    },
  }
})

require("nvim-treesitter.configs").setup({
  ensure_installed = { "rust", "typescript", "html", "javascript", "css", "norg", "prisma", "graphql", "vim", "lua" },
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(lang, bufnr) -- Disable in large C++ buffers
      return vim.api.nvim_buf_line_count(bufnr) > 5000 or vim.api.nvim_buf_get_name(bufnr) == 'generated.ts'
    end,
  },
  autotag = {
    enable = true,
    filetypes = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "rescript",
      "xml",
      "php",
      "markdown",
      "glimmer",
      "handlebars",
      "hbs",
      "liquid",
      "graphql",
    },
  },
})
