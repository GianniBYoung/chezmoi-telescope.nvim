local telescope = require("telescope")
local chezmoi = require("telescope._extensions.chezmoi.chezmoi")
local current_file = vim.fn.expand("%:p")

vim.api.nvim_create_user_command("ChezmoiAddCurrentFile", function()
	vim.fn.system("chezmoi add " .. current_file)
	print("Added to chezmoi: " .. current_file)
end, {})

vim.api.nvim_create_user_command("ChezmoiUpdate", function()
	vim.fn.system("chezmoi update")
	print("Pulling Chezmoi Latest Configuration!")
end, {})

vim.api.nvim_create_user_command("ChezmoiApply", function()
	vim.fn.system()
	print("Applying Chezmoi Config!")
end, {})

return telescope.register_extension({
	exports = {
		dotfiles = chezmoi.dotfiles,
	},
})
