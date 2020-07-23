{ stdenv, mkYarnPackage, sources, secretsConfig ? null }:
let
  pname = "nakarte";
  date = stdenv.lib.substring 0 10 sources.nakarte.date;
  version = "unstable-" + date;
in
mkYarnPackage {
  name = "${pname}-${version}";
  src = sources.nakarte;

  postPatch =
    if (secretsConfig != null) then
      "cp ${builtins.toFile "secrets.js" secretsConfig} src/secrets.js"
    else
      "cp src/secrets.js{.template,}";

  buildPhase = "yarn build";

  installPhase = ''
    install -dm755 $out/share/nginx
    mv deps/nakarte/build $out/share/nginx/html
  '';

  distPhase = "true";

  meta = with stdenv.lib; {
    inherit (sources.nakarte) description homepage;
    license = licenses.mit;
    maintainers = [ maintainers.sikmir ];
    platforms = platforms.all;
    broken = true; # error while evaluating 'importJSON', only on NUR CI
  };
}
