# web-dev.nvim

> Small Neovim configuration written in Lua that is specifically designed for web development.

* Small (~300 lines)
* Single-file
* Highly configurable

## Requirements

The _minimum_ recommended requirements are:

-   neovim `>= 0.7.0`

## Installation

* Run `./install`
* Start Neovim (`nvim`) and run `:PackerInstall` - ignore any error message about missing plugins, `:PackerInstall` will fix that shortly
* Restart Neovim

### Manually

* Backup your previous configuration
* Copy and paste the web-dev.nvim `init.lua` into `$HOME/.config/nvim/init.lua`

## Configuration

You could directly modify the `init.lua` file with your personal customizations. This option is the most straightforward, but if you update your config from this repo, you may need to reapply your changes.

An alternative approach is to create a separate `custom.plugins` module to register your own plugins. In addition, you can handle further customizations in the `/after/plugin/` directory (see `:help load-plugins`). Leveraging this technique should make upgrading to a newer version of this repo easier. 

## Disclamer

This repo is mostly for personal use only. The `after/plugin` directory contains personal configs that fit my workflow. You can also install them by running `./install all`.
