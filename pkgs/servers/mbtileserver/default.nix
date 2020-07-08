{ lib, buildGoModule, sources }:

buildGoModule {
  pname = "mbtileserver";
  version = lib.substring 0 7 sources.mbtileserver.rev;
  src = sources.mbtileserver;

  vendorSha256 = null;

  meta = with lib; {
    inherit (src) description homepage;
    license = licenses.isc;
    maintainers = with maintainers; [ sikmir ];
    platforms = platforms.unix;
  };
}
