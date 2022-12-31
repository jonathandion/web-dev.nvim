```
             __          __                    _     
 _    _____ / /  _______/ /__ _  __  ___ _  __(_)_ _ 
| |/|/ / -_) _ \/___/ _  / -_) |/ / / _ \ |/ / /  ' \
|__,__/\__/_.__/    \_,_/\__/|___(_)_//_/___/_/_/_/_/
                                                                                                               
```        

* Small: ~300 lines of code.
* Simple: one single file, easy to read and understand.
* Flexible: customize it to your specific needs and preferences.

## 📸 Screenshots

|                                                                                                                                                        |                                                                                                                                                  |                                                                                                                                        |
| :----------------------------------------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------------------------------------------------------------: |
|           <img width="500" src="https://user-images.githubusercontent.com/4976218/208801242-6ef86ccd-9a0e-4ed8-bc8a-a559ee230051.png">           |                 <img width="500" src="https://user-images.githubusercontent.com/4976218/208801332-95a610d9-de19-446e-8a0f-dc6651d003ea.png">                 | <img width="500" src="https://user-images.githubusercontent.com/4976218/208801498-8d65e1de-f3a8-4bc3-8f36-fc152fa15251.png"> |


## ⚡️ Requirements

The _minimum_ recommended requirements are:

- neovim `>= 0.7.0`

## 📦 Installation

* Run `./install`
* Start Neovim (`nvim`) and run `:PackerInstall` - ignore any error message about missing plugins, `:PackerInstall` will fix that shortly
* Restart Neovim

### Manually

* Backup your previous configuration
* Copy and paste the [init.lua](./src/init.lua) into `$HOME/.config/nvim/init.lua`

## ⚙️ Configuration

You could directly modify the `init.lua` file with your personal customizations. However, if you update your config from this repo, you may need to reapply your changes.

Alternatively, you can create a separate `custom.plugins` module to register your own plugins, and handle further customizations in the `/after/plugin/` directory (see :help load-plugins). This technique makes upgrading to a newer version of this repo easier.

The following is an example `custom.lua` file (located at `$HOME/.config/nvim/after/plugin/custom.lua`).

```
vim.opt.relativenumber = true
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
```

You can find my extra configuration file [here](./src/after/plugin/custom.lua) as an example.

## ⚠️ Disclamer

This repo is primarily for personal use. The `after/plugin` directory contains personal configs that fit my workflow. You can also install them by running `./install all`.
