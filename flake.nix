{
  description = "My Neovim Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {

          devShell = pkgs.mkShell {
            buildInputs = [
              pkgs.neovim
              pkgs.shellcheck
              pkgs.stylua
            ];

            shellHook =
              ''
                echo "Welcome to the Neovim dev-shell!"
              '';
          };

          defaultPackage =
            pkgs.stdenv.mkDerivation {
              name = "nvim-config";
              src = ./src/.;
              installPhase = ''
                mkdir -p $out
                cp -r ./**  $out
              '';
            };
        }
      );
}
