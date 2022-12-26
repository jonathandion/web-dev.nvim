{ pkgs, ... }:

{
  packages = [
    pkgs.neovim
    pkgs.stylua
    pkgs.shellcheck
  ];

  languages.nix.enable = true;
  languages.lua.enable = true;

  enterShell = ''
    echo "-----------------------------------------"
    echo "Run the following command to get started:"
    echo "$ install"
    echo "-----------------------------------------"
    echo ""
  '';

  scripts.install.exec = ''
    ./install && nvim -c 'PackerInstall'
  '';

  pre-commit.hooks = {
    shellcheck.enable = true;
    stylua.enable = true;
  };
}
