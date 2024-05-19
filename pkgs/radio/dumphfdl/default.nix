{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  fftwFloat,
  glib,
  libacars,
  libconfig,
  liquid-dsp,
  soapysdr,
  sqlite,
  zeromq,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "dumphfdl";
  version = "1.6.1";

  src = fetchFromGitHub {
    owner = "szpajder";
    repo = "dumphfdl";
    rev = "v${finalAttrs.version}";
    hash = "sha256-M4WjcGA15Kp+Hpp+I2Ndcx+oBqaGxEeQLTPcSlugLwQ=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    fftwFloat
    glib
    libacars
    libconfig
    liquid-dsp
    soapysdr
    sqlite
    zeromq
  ];

  meta = with lib; {
    description = "Multichannel HFDL decoder";
    inherit (finalAttrs.src.meta) homepage;
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.sikmir ];
    platforms = platforms.unix;
    broken = stdenv.isDarwin;
  };
})
