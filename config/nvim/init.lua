require('keymap')
require('plugins')

local vim = vim
local opt = vim.opt

vim.g.polyglot_disabled = { 'ftdetect' }
vim.g.matchparen_timeout = 60

vim.o.mouse = 'a'
vim.o.wrap = false
vim.opt.termguicolors = true
vim.o.signcolumn = 'yes'
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.synmaxcol = 200

vim.o.background = "dark" -- or "light" for light mode
vim.g.tokyonight_style = "night"
vim.cmd([[colorscheme tokyonight]])

-- Set spell check highlighting while Warp is still broken
vim.cmd [[hi clear SpellBad ]]
vim.cmd [[hi SpellBad gui=italic guifg=#990000]]

vim.wo.number = true


--------------------------------------------------------------------------------
-- BACKUP
--------------------------------------------------------------------------------

opt.backup = true                               -- Enable backups
opt.backupdir = vim.fn.expand("~/.local/share/nvim/backup/")
opt.backupskip = { '/tmp/*', '/private/tmp/*' } -- Make vim able to edit crontab files again
opt.swapfile = false                            -- It's 2021, Vim.
opt.undofile = true                             -- Enable undo history
opt.undodir = vim.fn.expand("~/.local/share/nvim/undo/")



local should_profile = os.getenv("NVIM_PROFILE")
if should_profile then
  require("profile").instrument_autocmds()
  if should_profile:lower():match("^start") then
    require("profile").start("*")
  else
    require("profile").instrument("*")
  end
end

local function toggle_profile()
  local prof = require("profile")
  if prof.is_recording() then
    prof.stop()
    vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
      if filename then
        prof.export(filename)
        vim.notify(string.format("Wrote %s", filename))
      end
    end)
  else
    prof.start("*")
  end
end
vim.keymap.set("", "<f1>", toggle_profile)
