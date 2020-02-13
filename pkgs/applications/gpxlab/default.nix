{ mkDerivation, lib, qmake, qtbase, qttools, qttranslations, sources }:

mkDerivation rec {
  pname = "gpxlab";
  version = lib.substring 0 7 src.rev;
  src = sources.gpxlab;

  nativeBuildInputs = [ qmake qttools ];
  buildInputs = [ qtbase qttranslations ];

  preConfigure = ''
    lrelease GPXLab/locale/*.ts
  '';

  enableParallelBuilding = true;

  meta = with lib; {
    inherit (src) description homepage;
    license = licenses.gpl3;
    maintainers = with maintainers; [ sikmir ];
    platforms = platforms.linux;
  };
}
