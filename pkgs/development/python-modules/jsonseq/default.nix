{ lib, python3Packages, sources }:
let
  pname = "jsonseq";
  date = lib.substring 0 10 sources.jsonseq.date;
  version = "unstable-" + date;
in
python3Packages.buildPythonPackage {
  inherit pname version;
  src = sources.jsonseq;

  meta = with lib; {
    inherit (sources.jsonseq) description homepage;
    license = licenses.mit;
    maintainers = with maintainers; [ sikmir ];
    platforms = platforms.unix;
  };
}