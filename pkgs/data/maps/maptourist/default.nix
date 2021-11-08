{ lib, stdenvNoCC, fetchurl, unzip }:

stdenvNoCC.mkDerivation rec {
  pname = "maptourist";
  version = "2021-11-07";

  src = fetchurl {
    url = "https://maptourist.org/osm-garmin/archive/OSM-MapTourist-szfo-RU_${version}.zip";
    hash = "sha256-G1pZxJaEY5D145sf7mYt6BMq/7v7hq4OUmQ6kGeTCzQ=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [ unzip ];

  installPhase = "install -Dm644 *.img -t $out";

  preferLocalBuild = true;

  meta = with lib; {
    description = "Ежедневная сборка карт из данных OpenStreetMap для навигационных приборов и приложений Garmin";
    homepage = "https://maptourist.org";
    license = licenses.free;
    maintainers = [ maintainers.sikmir ];
    platforms = platforms.all;
    skip.ci = true;
  };
}
