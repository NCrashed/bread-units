{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  bread-units-packages = import ./release.nix;
in stdenv.mkDerivation {
  name = "bread-units";

  buildInputs = with bread-units-packages; [
    bread-units-backend
  ];

  shellHook = ''
    echo "Started server. Press Ctrl+C to exit to nix shell and type exit to exit from it."
    cd bread-units-backend
    bread-units-backend
  '';
}
