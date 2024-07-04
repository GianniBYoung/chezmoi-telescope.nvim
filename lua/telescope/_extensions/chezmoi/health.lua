local health = {}

function health.check()
	vim.health.start("Telescope Chezmoi")
	if vim.fn.executable("chezmoi") == 1 then
		vim.health.ok("Chezmoi is installed:\n\n" .. vim.fn.system("chezmoi --version"))
	else
		vim.health.error("Chezmoi is not installed!!")
	end

	local has_telescope, _ = pcall(require, "telescope")
	if not has_telescope then
		error("This plugin requires nvim-telescope/telescope.nvim")
	end
end

return health
