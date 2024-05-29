# chezmoi-telescope.nvim
Custom Telescope Picker for Chez Moi Managed Dot files

# Installation
All that is needed is to install the plugin and load the `telescope extension` via `require("telescope").load_extension("chezmoi")`.

Here is an example with Lazy:
```lua
{
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "GianniBYoung/chezmoi-telescope.nvim" },
    },
    config = function()
        require("telescope").load_extension("chezmoi")
    end,
}
```

## Pre-reqs
-  [Chez Moi](https://www.chezmoi.io/)

-  [Telescope](https://github.com/nvim-telescope/telescope.nvim/tree/master)

-  [nvim-web-devicons (optional)](https://github.com/nvim-tree/nvim-web-devicons)

## Usage
`:Telescope chezmoi dotfiles`

# Features
This plugin provides a custom picker for telescope that populates results with files from `$CHEZMOI_SOURCE_DIR` and opens the result in a new buffer on selection.

# Roadmap
- Better icons in picker
- Create commands to `{add,re-add,remove,update,apply}` files
- Fix the naming bug
- Set ft on opening for templates

# Contributing
If this plugin is missing functionality for your use case please open an issue or submit a PR!
