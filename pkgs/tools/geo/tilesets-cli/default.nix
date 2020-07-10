{ lib, buildPythonApplication, boto3, click, cligj, requests, requests-toolbelt, jsonschema, jsonseq, sources }:
let
  pname = "tilesets-cli";
  date = lib.substring 0 10 sources.tilesets-cli.date;
  version = "unstable-" + date;
in
buildPythonApplication {
  inherit pname version;
  src = sources.tilesets-cli;

  propagatedBuildInputs = [ boto3 click cligj requests requests-toolbelt jsonschema jsonseq ];

  meta = with lib; {
    inherit (sources.tilesets-cli) description homepage;
    license = licenses.bsd2;
    maintainers = with maintainers; [ sikmir ];
    platforms = platforms.unix;
  };
}
