{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "osmptparser";
  version = "2.1.0";

  src = fetchFromGitHub {
    owner = "cualbondi";
    repo = "osmptparser";
    tag = "v${version}";
    hash = "sha256-+u1UP+hFI8fi+NAzQ4pIObo+ZCBBaEoIkUNvHPO7jSQ=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-Ds6fgL8aeRk/Pq6VmQupAZR8gN7Yl3c/LNCYigbE+CI=";

  doCheck = false;

  meta = {
    description = "Open Street Map Public Transport Parser";
    homepage = "https://github.com/cualbondi/osmptparser";
    license = lib.licenses.agpl3Plus;
    maintainers = [ lib.maintainers.sikmir ];
    mainProgram = "osmptparser";
  };
}
