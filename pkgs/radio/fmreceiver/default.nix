{ lib, stdenv, fetchFromGitHub, fftwFloat, libsamplerate, libsndfile, libusb1
, portaudio, rtl-sdr, qmake, qwt, wrapQtAppsHook
}:

stdenv.mkDerivation rec {
  pname = "fmreceiver";
  version = "2.1";

  src = fetchFromGitHub {
    owner = "JvanKatwijk";
    repo = "sdr-j-fm";
    rev = version;
    hash = "sha256-U0m9PIB+X+TBoz5FfXMvR/tZjkNIy7B613I7eLT5UIs=";
  };

  postPatch = ''
    substituteInPlace fmreceiver.pro \
      --replace "-lqwt-qt5" "-lqwt" \
      --replace "CONFIG" "#CONFIG" \
  '';

  nativeBuildInputs = [ qmake wrapQtAppsHook ];

  buildInputs = [ fftwFloat libsamplerate libsndfile libusb1 portaudio qwt ];

  qmakeFlags = [ "CONFIG+=dabstick" ];

  qtWrapperArgs = [
    "--prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ rtl-sdr ]}"
  ];

  installPhase = ''
    install -Dm755 linux-bin/fmreceiver-2.0 $out/bin/fmreceiver
  '';

  meta = with lib; {
    description = "A simple FM receiver";
    inherit (src.meta) homepage;
    license = licenses.gpl2Plus;
    maintainers = [ maintainers.sikmir ];
    platforms = platforms.linux;
    skip.ci = stdenv.isDarwin;
  };
}
