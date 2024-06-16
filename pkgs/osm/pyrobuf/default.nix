{
  lib,
  python3Packages,
  fetchFromGitHub,
}:

python3Packages.buildPythonPackage {
  pname = "pyrobuf";
  version = "0.9.3";

  src = fetchFromGitHub {
    owner = "appnexus";
    repo = "pyrobuf";
    rev = "811a9325eed1c0070ceb424020fe81eeef317e0c";
    hash = "sha256-7NEzRM9B/9f5ODNzDKws7t/9gqbJK7T9AuET+pT26P0=";
  };

  nativeBuildInputs = with python3Packages; [
    cython
    pytest-runner
  ];

  dependencies = with python3Packages; [ jinja2 ];

  nativeCheckInputs = with python3Packages; [ pytestCheckHook ];

  doCheck = false;

  meta = {
    description = "A Cython based protobuf compiler";
    homepage = "https://github.com/appnexus/pyrobuf";
    license = lib.licenses.asl20;
    maintainers = [ lib.maintainers.sikmir ];
  };
}
