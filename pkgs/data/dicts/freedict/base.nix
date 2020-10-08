{ stdenvNoCC, fetchurl, lang, version, sha256 }:

stdenvNoCC.mkDerivation {
  pname = "freedict-${lang}";
  inherit version;

  src = fetchurl {
    url = "https://download.freedict.org/dictionaries/${lang}/${version}/freedict-${lang}-${version}.dictd.tar.xz";
    inherit sha256;
  };

  installPhase = ''
    install -Dm644 **.{dict.dz,index} -t $out
  '';

  preferLocalBuild = true;

  meta = with stdenvNoCC.lib; {
    description = "FreeDict (${lang})";
    homepage = "https://freedict.org";
    license = licenses.free;
    maintainers = [ maintainers.sikmir ];
    platforms = platforms.all;
    skip.ci = true;
  };
}