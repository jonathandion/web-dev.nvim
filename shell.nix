{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    neovim
    alejandra
    shellcheck
    stylua
  ];

  shellHook = ''
    echo "Welcome to the Neovim dev-shell!"
  '';
}
