{ lib
, stdenv
, fetchFromGitHub
, cmake
, boost
, bzip2
, expat
, gdal
, libosmium
, protozero
, sqlite
, zlib
}:

stdenv.mkDerivation {
  pname = "osm-area-tools";
  version = "o-unstable-2023-06-15";

  src = fetchFromGitHub {
    owner = "osmcode";
    repo = "osm-area-tools";
    rev = "774443167f2e08222178253d83de359eb967d1e2";
    hash = "sha256-3RfZhexzaLx3CJol3gKkNP4f9z0ccT1l2WNf3EOuhkE=";
  };

  nativeBuildInputs = [ cmake ];

  buildInputs = [
    boost
    bzip2
    expat
    gdal
    libosmium
    protozero
    sqlite
    zlib
  ];

  meta = with lib; {
    description = "OSM Area Tools";
    homepage = "https://osmcode.org/osm-area-tools/";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.sikmir ];
    platforms = platforms.unix;
  };
}
