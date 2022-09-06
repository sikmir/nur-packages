{ lib, stdenv, fetchFromGitHub, autoreconfHook, pkg-config, cairo, librsvg
, Foundation, memstreamHook
, testers, smrender
}:

stdenv.mkDerivation rec {
  pname = "smrender";
  version = "4.3.0";

  src = fetchFromGitHub {
    owner = "rahra";
    repo = "smrender";
    rev = "v${version}";
    hash = "sha256-b9xuOPLxA9zZzIwWl+FTSW5XHgJ2sFoC578ZH6iwjaM=";
  };

  nativeBuildInputs = [ autoreconfHook pkg-config ];

  buildInputs = [ cairo librsvg ]
    ++ lib.optionals stdenv.isDarwin [ Foundation memstreamHook ];

  passthru.tests.version = testers.testVersion {
    package = smrender;
    version = "V${version}";
  };

  meta = with lib; {
    description = "A powerful, flexible, and modular rule-based rendering engine for OSM data";
    inherit (src.meta) homepage;
    license = licenses.gpl3Only;
    maintainers = [ maintainers.sikmir ];
    platforms = platforms.unix;
  };
}
