{ stdenv, libpng, pkg-config, datamaps }:

stdenv.mkDerivation rec {
  pname = "datamaps";
  version = stdenv.lib.substring 0 7 src.rev;
  src = datamaps;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libpng ];

  makeFlags = [ "PREFIX=$(out)" ];
  enableParallelBuilding = true;

  installPhase = ''
    install -Dm755 encode $out/bin/datamaps-encode
    install -Dm755 enumerate $out/bin/datamaps-enumerate
    install -Dm755 merge $out/bin/datamaps-merge
    install -Dm755 render $out/bin/datamaps-render
  '';

  meta = with stdenv.lib; {
    description = datamaps.description;
    homepage = https://github.com/ericfischer/datamaps;
    license = licenses.bsd2;
    maintainers = with maintainers; [ sikmir ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
