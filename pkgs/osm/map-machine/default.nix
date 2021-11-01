{ lib, fetchFromGitHub, python3Packages, portolan }:

python3Packages.buildPythonApplication rec {
  pname = "map-machine";
  version = "2021-11-01";
  disabled = python3Packages.pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "enzet";
    repo = pname;
    rev = "a73006e67eec43772b7d94ab4c2a532eb05531c7";
    hash = "sha256-8o368y98L77JOonAP7DrqfwBU/wQ/SdNmWe7I9Y2xro=";
  };

  propagatedBuildInputs = with python3Packages; [
    cairosvg
    colour
    numpy
    pillow
    portolan
    pycairo
    pyyaml
    shapely
    svgwrite
    urllib3
  ];

  checkInputs = with python3Packages; [ pytestCheckHook ];
  preCheck = "export PATH=$PATH:$out/bin";
  disabledTests = [
    "test_tile"
  ];

  meta = with lib; {
    description = "A simple renderer for OpenStreetMap with custom icons";
    inherit (src.meta) homepage;
    license = licenses.mit;
    maintainers = [ maintainers.sikmir ];
  };
}
