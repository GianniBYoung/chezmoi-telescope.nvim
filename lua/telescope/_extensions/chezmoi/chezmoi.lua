local M = {}

-- prereqs
local has_telescope, _ = pcall(require, "telescope")
if not has_telescope then
	error("This plugin requires nvim-telescope/telescope.nvim")
end

local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local entry_display = require("telescope.pickers.entry_display")
local make_entry = require("telescope.make_entry")
local has_devicons, devicons = pcall(require, "nvim-web-devicons")

-- Populate results with files from $CHEZMOI_SOURCE_DIR replacing 'dot_' with '.' and trimming the off the leading path in the display
M.dotfiles = function(opts)
	opts = opts or {}
	local results = {}
	local chezmoi_source_dir = os.getenv("CHEZMOI_SOURCE_DIR") or "~/.local/share/chezmoi"

	local handle = io.popen("find " .. chezmoi_source_dir .. ' -type f ! -path "*/.git/*" ! -name ".*"')
	-- need to append .chez and other hidden files but not git specific ones
	if handle then
		for line in handle:lines() do
			local relative_path = line:sub(#chezmoi_source_dir + 2):gsub("dot_", ".")
			table.insert(results, { full_path = line, display = relative_path })
		end
		handle:close()
	end

	table.sort(results, function(a, b)
		return a.display < b.display
	end)

	pickers
		.new(opts, {
			prompt_title = "Chezmoi Managed Dot Files",
			finder = finders.new_table({
				results = results,
				entry_maker = function(entry)
					local icon = has_devicons
							and devicons.get_icon(
								entry.full_path,
								string.match(entry.full_path, "%.%w+$"),
								{ default = true }
							)
						or ""

					return {
						value = entry.full_path,
						display = icon and (icon .. " " .. entry.display) or entry.display,
						ordinal = entry.display,
						filename = entry.full_path,
					}
				end,
			}),
			sorter = sorters.get_fuzzy_file(),
			previewer = previewers.cat.new(opts),
		})
		:find()
end

return M
