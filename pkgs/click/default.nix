{ stdenv, buildPythonPackage, fetchPypi, substituteAll, locale, pytest }:

buildPythonPackage rec {
  pname = "click";
  version = "6.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "02qkfpykbq35id8glfgwc38yc430427yd05z1wc5cnld8zgicmgi";
  };

  patches = stdenv.lib.optional (stdenv.lib.versionAtLeast version "6.7") (substituteAll {
    src = ./fix-paths.patch;
    locale = "${locale}/bin/locale";
  });

  buildInputs = [ pytest ];

  checkPhase = ''
    py.test tests
  '';

  # https://github.com/pallets/click/issues/823
  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://click.pocoo.org/;
    description = "Create beautiful command line interfaces in Python";
    license = licenses.bsd3;
  };
}
