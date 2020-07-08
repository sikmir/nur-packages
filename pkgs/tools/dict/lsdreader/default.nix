{ lib, buildPythonApplication, sources }:

buildPythonApplication {
  pname = "lsdreader";
  version = lib.substring 0 7 sources.lsdreader.rev;
  src = sources.lsdreader;

  doCheck = false;

  meta = with lib; {
    inherit (src) description homepage;
    license = licenses.free;
    maintainers = with maintainers; [ sikmir ];
    platforms = platforms.unix;
  };
}
