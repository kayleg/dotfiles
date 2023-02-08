vim.filetype.add({
	extension = {
		prisma = function(path, bufnr)
			return 'prisma'
		end
	},
})
