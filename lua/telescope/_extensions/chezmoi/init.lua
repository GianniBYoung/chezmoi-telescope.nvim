local telescope = require("telescope")
local chezmoi = require("telescope._extensions.chezmoi.chezmoi")

return telescope.register_extension({
	exports = {
		dotfiles = chezmoi.dotfiles,
	},
})
