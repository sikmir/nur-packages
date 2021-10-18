{ lib, stdenv, fetchFromSourcehut, libpng, libjpeg, libtiff, libwebp, fftwFloat, libX11, gsl }:

stdenv.mkDerivation rec {
  pname = "imscript";
  version = "2021-10-12";

  src = fetchFromSourcehut {
    owner = "~coco";
    repo = pname;
    rev = "f500690dbdf46aa693132c20dd09b5e538ce193e";
    hash = "sha256-EnYpOmkkZW6cnUjcwgRw6v+/BcptSkaE/BwGjOOAVU8=";
  };

  buildInputs = [ libpng libjpeg libtiff libwebp fftwFloat libX11 gsl ];

  makeFlags = [ "DISABLE_HDF5=1" "full" ];

  enableParallelBuilding = true;

  installPhase = ''
    install -Dm755 bin/* -t $out/bin
    install -Dm644 doc/man/* -t $out/share/man/man1
  '';

  meta = with lib; {
    description = "A collection of small and standalone utilities for image processing";
    inherit (src.meta) homepage;
    license = licenses.agpl3;
    maintainers = [ maintainers.sikmir ];
    platforms = platforms.unix;
  };
}
