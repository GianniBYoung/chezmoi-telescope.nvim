# chezmoi-telescope.nvim

Custom Telescope Picker for Chez Moi Managed Dot Files!

Also adds neovim commands to:

- `add`

- `forget`

- `update` chezmoi's source

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

`:Telescope chezmoi dotfiles` -> Open telescope picker populated with Chezmoi managed dot files

`:ChezmoiAdd` -> Add the current file to Chezmoi

`:ChezmoiRemove` -> Remove the current file from Chezmoi

`:ChezmoiUpdate` -> Pull down the remote source

# Features

This plugin provides a custom picker for telescope that populates results with files from `$CHEZMOI_SOURCE_DIR` and opens the result in a new buffer on selection.

# Roadmap

- Better icons in picker

- Configuration options
  - Include or exclude `tmpl` extension (current default is to exclude)
  - Set FT on opening

# Contributing

If this plugin is missing functionality for your use case please open an issue or submit a PR!
