{ lib, buildGoModule, pkgconfig, portaudio, sources }:

buildGoModule rec {
  pname = "musig-unstable";
  version = lib.substring 0 10 sources.musig.date;

  src = sources.musig;

  vendorSha256 = "0ha1xjdwibm8543b4bx0xrbigngiiakksdc6mnp0mz5y6ai56pg5";

  nativeBuildInputs = [ pkgconfig ];

  buildInputs = [ portaudio ];

  buildFlagsArray = ''
    -ldflags=
      -X main.VERSION=${version}
  '';

  meta = with lib; {
    inherit (sources.musig) description homepage;
    license = licenses.mit;
    maintainers = [ maintainers.sikmir ];
    platforms = platforms.unix;
  };
}
