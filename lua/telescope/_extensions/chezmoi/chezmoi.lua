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
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local chezmoi_source_dir = io.popen("chezmoi source-path"):read("*a"):gsub("%s+", "")

local function set_buffer_filetype(path)
	local filetype = vim.filetype.match({ filename = path })
	if filetype then
		vim.bo.filetype = filetype
	else
		print("Could not detect filetype for: " .. path)
	end
end

local function populatePicker()
	local results = {}
	local handle =
		io.popen("find " .. chezmoi_source_dir .. ' -type f ! -path "*/.git/*" ! -name ".*" -o -name ".chezmoi*"')
	if handle then
		for line in handle:lines() do
			local relative_path = line:sub(#chezmoi_source_dir + 2):gsub("dot_", "."):gsub("%.tmpl$", "")
			table.insert(results, { full_path = line, display = relative_path })
		end
		handle:close()
	end
	return results
end

-- Populate results with files from $CHEZMOI_SOURCE_DIR replacing 'dot_' with '.' and trimming the off the leading path in the display
M.dotfiles = function(opts)
	opts = opts or {}
	local results = populatePicker()

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
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					vim.cmd("edit " .. selection.value)
					set_buffer_filetype(selection.display)
				end)

				return true
			end,
		})
		:find()
end

M.livedotfiles = function(opts)
	opts = opts or {}
	local results = populatePicker()

	pickers
		.new(opts, {
			prompt_title = "Chezmoi Managed Dot Files (The ones in use!)",
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
						filename = "$HOME/" .. entry.display,
					}
				end,
			}),
			sorter = sorters.get_fuzzy_file(),
			previewer = previewers.cat.new(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					vim.cmd("edit " .. selection.filename)
				end)

				return true
			end,
		})
		:find()
end
return M
