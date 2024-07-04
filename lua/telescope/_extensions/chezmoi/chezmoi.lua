local M = {}

local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local has_devicons, devicons = pcall(require, "nvim-web-devicons")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local chezmoi_source_dir = io.popen("chezmoi source-path"):read("*a"):gsub("%s+", "")

local function set_buffer_filetype(path)
	local filetype = vim.filetype.match({ filename = path })
	if filetype then
		vim.bo.filetype = filetype
	else
		vim.notify("Could not detect filetype for: " .. path)
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

local function chezmoiEntry(entry, opts)
	local icon = ""
	if opts.icons and has_devicons then
		icon = devicons.get_icon(entry.full_path, string.match(entry.full_path, "%.%w+$"), { default = true })
	end

	local filename = entry.full_path
	if opts.liveDots then
		filename = "$HOME/" .. entry.display
	end

	return {
		value = entry.full_path,
		display = icon and (icon .. " " .. entry.display) or entry.display,
		ordinal = entry.display,
		filename = filename,
	}
end

-- Populate results with files from $CHEZMOI_SOURCE_DIR replacing 'dot_' with '.' and trimming the off the leading path in the display
M.dotfiles = function(opts)
	opts = opts or {}
	opts.icons = opts.icons ~= false
	opts.liveDots = opts.liveDots == true
	local results = populatePicker()
	local pt = "Chezmoi Managed Dot Files"
	if opts.liveDots then
		pt = "Live Chezmoi Managed Dot Files! (The ones in use!!)"
	end

	pickers
		.new(opts, {
			prompt_title = pt,
			finder = finders.new_table({
				results = results,
				entry_maker = function(entry)
					return chezmoiEntry(entry, opts)
				end,
			}),
			sorter = sorters.get_fuzzy_file(),
			previewer = previewers.cat.new(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					if opts.liveDots then
						vim.cmd("edit " .. selection.filename)
					else
						vim.cmd("edit " .. selection.value)
						set_buffer_filetype(selection.display)
					end
				end)

				return true
			end,
		})
		:find()
end
return M
