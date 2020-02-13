{ mkDerivation, lib, qmake, qtbase, qttools, qttranslations, sources }:

mkDerivation rec {
  pname = "gpxsee";
  version = lib.substring 0 7 src.rev;
  src = sources.gpxsee;

  nativeBuildInputs = [ qmake qttools ];
  buildInputs = [ qtbase qttranslations ];

  preConfigure = ''
    lrelease lang/*.ts
  '';

  enableParallelBuilding = true;

  meta = with lib; {
    inherit (src) description homepage;
    license = licenses.gpl3;
    maintainers = with maintainers; [ sikmir ];
    platforms = platforms.linux;
  };
}
