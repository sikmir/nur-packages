{ lib, buildPythonApplication, libX11, libXext, xlib, pillow, docopt, psutil
, attrs, ueberzug }:

buildPythonApplication rec {
  pname = "ueberzug";
  version = lib.substring 0 7 src.rev;
  src = ueberzug;

  buildInputs = [ libX11 libXext ];
  propagatedBuildInputs = [ xlib pillow docopt psutil attrs ];

  meta = with lib; {
    description = ueberzug.description;
    homepage = "https://github.com/seebye/ueberzug";
    license = licenses.gpl3;
    platforms = platforms.unix;
    maintainers = with maintainers; [ sikmir ];
  };
}
