{ lib, stdenvNoCC, fetchurl, unzip }:

stdenvNoCC.mkDerivation rec {
  pname = "maptourist";
  version = "2021-10-14";

  src = fetchurl {
    url = "https://maptourist.org/osm-garmin/archive/OSM-MapTourist-szfo-RU_${version}.zip";
    hash = "sha256-DAt4EHeCSX5OysDpf1UHHra20skUXfiuW2kJtvn79I4=";
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
