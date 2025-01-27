# chezmoi-telescope.nvim

Custom Telescope Picker for Chez Moi Managed Dot Files!

Also adds neovim commands to:

- `add`

- `forget`

- 're-add'
  - Chezmoi does not overwrite template files and neither will this command

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

- `:Telescope chezmoi dotfiles` -> Open telescope picker populated with Chezmoi managed dot files
  - This opens the file in chezmoi's source dir

- `:Telescope chezmoi dotfiles liveDots=true` -> Open telescope picker populated with (Live) Chezmoi managed dot files
  - This opens the actual dotfile on your system

- `:ChezmoiAdd` -> `add` the current file to Chezmoi

- `:ChezmoiReAdd` -> `re-add` the current file to Chezmoi

- `:ChezmoiRemove` -> `remove` the current file from Chezmoi

- `:ChezmoiUpdate` -> Pull down the remote source

### Options
The available options are:
- `icons` bool(true) - Enable or disable icons
- `liveDots` bool(false) - Populate the picker with the actual dotfiles your system is using - aka 'live dot files'

Options can be set in the following ways:

1. `:Telescope chezmoi dotfiles option1=value1 option2=bool2`

2. `require('telescope').extensions.chezmoi.dotfiles({option1="value1", option2=bool2})`

# Features

This plugin provides a custom picker for telescope that populates results with files from `$CHEZMOI_SOURCE_DIR` and opens the result in a new buffer on selection.

# Roadmap

- Better icons in picker

- Better error handling

# Contributing

If this plugin is missing functionality for your use case please open an issue or submit a PR!
