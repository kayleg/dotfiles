vim.filetype.add({
  extension = {
    prisma = function(path, bufnr)
      return 'prisma'
    end
  },
})

vim.api.nvim_create_augroup("neogit-additions", {})
vim.api.nvim_create_autocmd("FileType", {
  group = "neogit-additions",
  pattern = "NeogitCommitMessage",
  command = "silent! set filetype=gitcommit",
})
