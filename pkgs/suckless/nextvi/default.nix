{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "nextvi";
  version = "2022-06-04";

  src = fetchFromGitHub {
    owner = "kyx0r";
    repo = pname;
    rev = "bf25beff4a0fc26b95955f29f7614f3cec855b09";
    hash = "sha256-BRIZF+D+2nxnLXaVw+e78iAQIgQOt+IHPcn2BN/6TT4=";
  };

  buildPhase = ''
    CFLAGS=-D_DARWIN_C_SOURCE sh ./build.sh
  '';

  installPhase = ''
    PREFIX=$out sh ./build.sh install
  '';

  meta = with lib; {
    description = "Next version of neatvi (a small vi/ex editor)";
    inherit (src.meta) homepage;
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = [ maintainers.sikmir ];
  };
}
