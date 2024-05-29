# chezmoi-telescope.nvim
Custom Telescope Picker or Chez Moi Managed Dot files

# Installation
Install with Lazy:
```lua
{
    'GianniBYoung/chezmoi-telescope.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('telescope').load_extension('chezmoi')
    end
  }
```
## Pre-reqs
- Telescope
- Dev Icons
- Chez Moi

## Usage
`:Telescope chezmoi dotfiles`

# Features
This plugin provides a custom picker for telescope that populates results with files from `$CHEZMOI_SOURCE_DIR`.

# Roadmap
- Better icons in picker
- Create commands to `{add,re-add,remove}` files

# Contributing
If this plugin is missing functionality for your use case please open an issue or submit a PR!
