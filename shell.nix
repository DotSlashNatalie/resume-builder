{ pkgs ? import <nixpkgs> { } }:
let
        oldpkgs = import (builtins.fetchTarball {
                          url = "https://github.com/NixOS/nixpkgs/archive/b459c8475c58f7c8d529ebeadcbebbfe00ddf6eb.tar.gz";
                      }) {};
in
pkgs.mkShell {
  nativeBuildInputs = [
   pkgs.gnumake
   oldpkgs.pandoc
   pkgs.texlive.combined.scheme-context
  ];
}
