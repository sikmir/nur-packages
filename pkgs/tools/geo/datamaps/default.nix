{ stdenv, libpng, pkg-config, sources }:

stdenv.mkDerivation {
  pname = "datamaps";
  version = stdenv.lib.substring 0 7 sources.datamaps.rev;
  src = sources.datamaps;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libpng ];

  makeFlags = [ "PREFIX=$(out)" ];
  enableParallelBuilding = true;

  installPhase = ''
    for tool in encode enumerate merge render; do
      install -Dm755 $tool $out/bin/$pname-$tool
    done
  '';

  meta = with stdenv.lib; {
    inherit (sources.datamaps) description homepage;
    license = licenses.bsd2;
    maintainers = with maintainers; [ sikmir ];
    platforms = with platforms; linux ++ darwin;
  };
}
