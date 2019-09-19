{ lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name = "geoip2-csv-converter-${version}";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "maxmind";
    repo = "geoip2-csv-converter";
    rev = "v${version}";
    sha256 = "1xd9102haikaxbljhjszvsy8gkj0wil3bni70pwq53xamni246d1";
  };

  goDeps = ./deps.nix;
  goPackagePath = "github.com/maxmind/geoip2-csv-converter";
}
