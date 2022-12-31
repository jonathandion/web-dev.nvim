{
  description = "My Neovim Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    defaultPackage.aarch64-darwin =
      with import nixpkgs { system = "aarch64-darwin"; };

      pkgs.stdenv.mkDerivation {
        name = "nvim-config";

        src = ./src/.;

        installPhase = ''
          mkdir -p $out
          cp -r ./**  $out
        '';
      };
  };
}
