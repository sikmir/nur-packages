{ stdenv
, fetchFromGitHub
, substituteAll
, db
, giflib
, gsettings-desktop-schemas
, gtkmm3
, jansson
, curl
, libjpeg
, libpng
, librsvg
, libtiff
, libxml2
, libzip
, perlPackages
, pkgconfig
, proj
, shapelib
, unzip
, wrapGAppsHook
}:

stdenv.mkDerivation rec {
  pname = "mapsoft2";
  version = "1.3";

  src = fetchFromGitHub {
    owner = "slazav";
    repo = pname;
    rev = "${version}-alt1";
    sha256 = "1jal7k2wm7b3mjkd8r68bp0bh8gqyzlwbdkyhxpx5gm8mqv2fnxx";
    fetchSubmodules = true;
  };

  patches = [
    (
      substituteAll {
        src = ./0002-fix-build.patch;
        db = db.dev;
        giflib = giflib;
      }
    )
  ];

  postPatch = ''
    substituteInPlace modules/get_deps \
      --replace "/usr/bin/perl" "${perlPackages.perl}/bin/perl"
    substituteInPlace modules/mapview/mapview.cpp \
      --replace "/usr/share" "${placeholder "out"}/share"
    patchShebangs .
  '';

  nativeBuildInputs = [
    perlPackages.perl
    pkgconfig
    unzip
    wrapGAppsHook
  ];
  buildInputs = [
    db
    gsettings-desktop-schemas
    gtkmm3
    jansson
    curl
    libjpeg
    libpng
    librsvg
    libtiff
    libxml2
    libzip
    proj
    shapelib
  ];

  dontConfigure = true;

  preBuild = "export SKIP_IMG_DIFFS=1";

  makeFlags = [ "prefix=${placeholder "out"}" ];

  meta = with stdenv.lib; {
    description = "A collection of tools and libraries for working with maps and geo-data";
    homepage = "http://slazav.github.io/mapsoft2";
    license = licenses.gpl3;
    maintainers = [ maintainers.sikmir ];
    platforms = platforms.linux;
    skip.ci = stdenv.isDarwin;
  };
}
