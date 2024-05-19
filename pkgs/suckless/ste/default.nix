{
  lib,
  stdenv,
  fetchFromSourcehut,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "ste";
  version = "0.7.1";

  src = fetchFromSourcehut {
    owner = "~strahinja";
    repo = "ste";
    rev = "v${finalAttrs.version}";
    hash = "sha256-rtwM2UZ+ncA5SPg5yt1HlacasdhTov6emiUnByE6VHM=";
  };

  FALLBACKVER = finalAttrs.version;

  installFlags = [ "PREFIX=$(out)" ];

  meta = with lib; {
    description = "Simple table editor";
    homepage = "https://strahinja.srht.site/ste";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.sikmir ];
    platforms = platforms.linux;
    skip.ci = stdenv.isDarwin;
    mainProgram = "ste";
  };
})
