{
  lib,
  mkYarnPackage,
  fetchFromGitHub,
  secretsConfig ? null,
}:
let
  pname = "nakarte";
  version = "2025-12-07";
in
mkYarnPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "sikmir";
    repo = "nakarte";
    rev = "67545a23da06e94bb17c95bf58a7b06128abd9ec";
    hash = "sha256-HO1RJBMURCtGWvTD52x9WM/T9E9JnnsLJv7xbt0cQSA=";
  };

  postPatch =
    if (secretsConfig != null) then
      "cp ${builtins.toFile "secrets.js" secretsConfig} src/secrets.js"
    else
      "cp src/secrets.js{.template,}";

  buildPhase = ''
    runHook preBuild

    yarn build

    runHook postBuild
  '';

  installPhase = ''
    install -dm755 $out
    cp -r deps/nakarte/build/* $out
  '';

  distPhase = "true";

  meta = {
    homepage = "https://github.com/sikmir/nakarte";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.sikmir ];
    platforms = lib.platforms.all;
    skip.ci = true;
  };
}
