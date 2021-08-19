{ lib, stdenv, fetchgit }:

stdenv.mkDerivation rec {
  pname = "gpx2yaml";
  version = "2021-08-19";

  src = fetchgit {
    url = "git://git.sikmir.ru/${pname}";
    rev = "bc8f175d022d68e7712535a29cc2c08d9c79254e";
    sha256 = "sha256-82RYdC1tUYwYZELTHOC+Llz+KcdLgyipB9wEWekDRww=";
  };

  installFlags = [ "PREFIX=$(out)" ];

  meta = with lib; {
    description = "GPX to YAML converter";
    homepage = "https://git.sikmir.ru/gpx2yaml/file/README.md.html";
    license = licenses.isc;
    maintainers = [ maintainers.sikmir ];
    platforms = platforms.unix;
  };
}
