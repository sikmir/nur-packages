{ lib, buildGoModule, sources }:

buildGoModule rec {
  pname = "mbtileserver";
  version = lib.substring 0 7 src.rev;
  src = sources.mbtileserver;

  modSha256 = "147rpf3dd0md7pm7yfniy139kv3fb3kmyp82slpjrf8xdqgbrpk0";

  meta = with lib; {
    inherit (src) description homepage;
    license = licenses.isc;
    maintainers = with maintainers; [ sikmir ];
    platforms = platforms.unix;
  };
}
