{
  lib,
  stdenv,
  fetchFromGitHub,
  fontconfig,
  imlib2,
  libXft,
  conf ? null,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "mage";
  version = "0.8-unstable-2022-12-30";

  src = fetchFromGitHub {
    owner = "explosion-mental";
    repo = "mage";
    rev = "15ce5485379cc4d3d1bfdec49beccaffd9fb6c30";
    hash = "sha256-v119RZAygmcdKnu6GpDvdw+yW2jiDQ7WyjLC2vQVXyw=";
  };

  configFile = lib.optionalString (conf != null) (builtins.toFile "config.h" conf);
  preBuild = lib.optionalString (conf != null) "cp ${finalAttrs.configFile} config.h";

  buildInputs = [
    fontconfig
    imlib2
    libXft
  ];

  makeFlags = [ "CC:=$(CC)" ];

  installFlags = [ "PREFIX=$(out)" ];

  meta = with lib; {
    description = "iMAGE viewer";
    inherit (finalAttrs.src.meta) homepage;
    license = licenses.gpl2Only;
    maintainers = [ maintainers.sikmir ];
    platforms = platforms.linux;
    skip.ci = stdenv.isDarwin;
  };
})
