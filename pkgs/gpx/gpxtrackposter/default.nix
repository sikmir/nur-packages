{
  lib,
  fetchFromGitHub,
  python3Packages,
  s2sphere,
  unstableGitUpdater,
}:

python3Packages.buildPythonApplication {
  pname = "gpxtrackposter";
  version = "0-unstable-2024-06-02";

  src = fetchFromGitHub {
    owner = "flopp";
    repo = "GpxTrackPoster";
    rev = "1ca04e9f2fb4a5ee33e2fb0863e6169ecb2c99a0";
    hash = "sha256-0Bdls3Pe1K/3QSK9vsfcIxr3arB4/PZ+IsQO5Pk180E=";
  };

  patches = [
    ./fix-localedir.patch
  ];

  postPatch = ''
    substituteInPlace gpxtrackposter/poster.py \
      --replace-fail "self.translate(\"ATHLETE\")" "\"\""
    substituteInPlace gpxtrackposter/track.py \
      --replace-fail "from stravalib.model import Activity" "from stravalib.model import DetailedActivity"
    substituteInPlace gpxtrackposter/cli.py \
      --subst-var out
  '';

  dependencies = with python3Packages; [
    appdirs
    colour
    geopy
    gpxpy
    pint
    pytz
    s2sphere
    svgwrite
    stravalib
    polyline
    timezonefinder
    setuptools
  ];

  nativeCheckInputs = with python3Packages; [
    pytestCheckHook
    (pytest-mock.overrideAttrs (old: rec {
      pname = "pytest-mock";
      version = "3.3.1";
      src = fetchPypi {
        inherit pname version;
        hash = "sha256-pNbTcynkqJPnfZ/6ieg43StF1dwJmYTPA8cDrIQRu4I=";
      };
    }))
  ];

  doCheck = false;

  postInstall = "rm -fr $out/requirements*.txt";

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    description = "Create a visually appealing poster from your GPX tracks";
    homepage = "https://github.com/flopp/GpxTrackPoster";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.sikmir ];
  };
}
