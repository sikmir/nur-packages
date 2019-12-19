{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  sources = import ./nix/sources.nix;
in
{
  datamaps = callPackage ./pkgs/datamaps { inherit (sources) datamaps; };
  gpx-layer = perlPackages.callPackage ./pkgs/gpx-layer { inherit (sources) gpx-layer; };
  gpxpy = python3Packages.callPackage ./pkgs/gpxpy { inherit (sources) gpxpy; };
  mbutil = python3Packages.callPackage ./pkgs/mbutil { inherit (sources) mbutil; };
}
