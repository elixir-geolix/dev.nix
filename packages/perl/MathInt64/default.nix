{ stdenv, pkgs, buildPerlPackage, fetchurl }:

# nix-generate-from-cpan
buildPerlPackage rec {
  pname = "Math-Int64";
  version = "0.54";

  src = fetchurl {
    url = "mirror://cpan/authors/id/S/SA/SALVA/${pname}-${version}.tar.gz";
    sha256 = "dcfc51e698437ea6b9cefe0276215c56cdb6a7f85e3e24a2b6b4189f1960d351";
  };

  buildInputs = with pkgs; [ perl ];

  meta = {
    homepage = http://metacpan.org/release/Math-Int64;
    description = "Manipulate 64 bits integers in Perl";
    license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
