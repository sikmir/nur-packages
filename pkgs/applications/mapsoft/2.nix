{ stdenv
, fetchFromGitHub
, substituteAll
, db
, giflib
, gsettings-desktop-schemas
, gtkmm3
, jansson
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
}:

stdenv.mkDerivation rec {
  pname = "mapsoft2";
  version = "2020-03-20";

  src = fetchFromGitHub {
    owner = "slazav";
    repo = pname;
    rev = "44ba9ac966ebf5b8f3cc21c4333b431a3ca9708a";
    sha256 = "18d3c5ih0rfywkk9nrkiqr689rimyh86gzmbj1q72f1yz5ssc42v";
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
  ];
  buildInputs = [
    db
    gsettings-desktop-schemas
    gtkmm3
    jansson
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
    maintainers = with maintainers; [ sikmir ];
    platforms = platforms.linux;
  };
}
