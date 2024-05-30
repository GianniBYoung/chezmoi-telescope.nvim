local telescope = require("telescope")
local chezmoi = require("telescope._extensions.chezmoi.chezmoi")

vim.api.nvim_create_user_command("ChezmoiAdd", function()
	local current_file = vim.fn.expand("%:p")
	vim.fn.system("chezmoi add " .. current_file)
	print("Added to chezmoi: " .. current_file)
end, {})

vim.api.nvim_create_user_command("ChezmoiForget", function()
	local current_file = vim.fn.expand("%:p")
	vim.fn.system("chezmoi forget --force " .. current_file)
	print("Removing chezmoi file: " .. current_file)
end, {})

vim.api.nvim_create_user_command("ChezmoiUpdate", function()
	vim.fn.system("chezmoi update")
	print("Pulling Chezmoi Latest Configuration!")
end, {})

return telescope.register_extension({
	exports = {
		dotfiles = chezmoi.dotfiles,
	},
})
