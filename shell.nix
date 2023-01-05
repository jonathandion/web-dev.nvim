{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    neovim
    shellcheck
    stylua
  ];

  shellHook =
    ''
      echo "Welcome to the Neovim dev-shell!"
    '';
}
