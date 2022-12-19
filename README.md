# web-dev.nvim

> Small Neovim configuration written in Lua that is specifically designed for web development.

* Small: ~300 lines of code.
* Simple: one single file, easy to read and understand.
* Flexible: customize it to your specific needs and preferences.

## Requirements

The _minimum_ recommended requirements are:

- neovim `>= 0.7.0`

## Installation

* Run `./install`
* Start Neovim (`nvim`) and run `:PackerInstall` - ignore any error message about missing plugins, `:PackerInstall` will fix that shortly
* Restart Neovim

### Manually

* Backup your previous configuration
* Copy and paste the [init.lua](./src/init.lua) into `$HOME/.config/nvim/init.lua`

## Configuration

You could directly modify the `init.lua` file with your personal customizations. However, if you update your config from this repo, you may need to reapply your changes.

Alternatively, you can create a separate `custom.plugins` module to register your own plugins, and handle further customizations in the `/after/plugin/` directory (see :help load-plugins). This technique makes upgrading to a newer version of this repo easier.

## Disclamer

This repo is primarily for personal use. The `after/plugin` directory contains personal configs that fit my workflow. You can also install them by running `./install all`.
