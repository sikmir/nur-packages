{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule {
  pname = "homescript";
  version = "0-unstable-2025-12-15";

  src = fetchFromGitHub {
    owner = "homescript-dev";
    repo = "server";
    rev = "3cb9a7f0d5175f9c5e5ddfd596cbe77631ac9c31";
    hash = "sha256-aqeuhuXw+CJ94sJSMls09xiiWoTiw11oJddpwhQXdk8=";
  };

  vendorHash = "sha256-VNiN4sNPDFKZOmi5WYLnUTffsyFjS7VYMHdVxr3kuIs=";

  postInstall = ''
    mv $out/bin/{,homescript-}server
  '';

  meta = {
    description = "Homescript Server";
    homepage = "https://github.com/homescript-dev/server";
    license = lib.licenses.free;
    maintainers = [ lib.maintainers.sikmir ];
    platforms = lib.platforms.unix;
  };
}
