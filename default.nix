{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  name = "nvim-config";
  src = ./src/.;
  installPhase = ''
    mkdir -p $out
    cp -r ./**  $out
  '';
}
