{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  sources = import ./nix/sources.nix;
in
{
  datamaps = callPackage ./pkgs/datamaps { inherit (sources) datamaps; };
  mbutil = python3Packages.callPackage ./pkgs/mbutil { inherit (sources) mbutil; };
  gpx-layer = perlPackages.callPackage ./pkgs/gpx-layer { inherit (sources) gpx-layer; };
}
