{ stdenv, pkgs, buildPerlPackage, fetchurl }:

# nix-generate-from-cpan
buildPerlPackage rec {
  perl_MathInt64 = pkgs.callPackage ../MathInt64 {};

  name = "Math-Int128-0.22";
  src = fetchurl {
    url = "mirror://cpan/authors/id/S/SA/SALVA/${name}.tar.gz";
    sha256 = "a630ca401753866955f1173848ab5b4ac4ad5ca6ad9087f11cdf91dde85119bc";
  };

  propagatedBuildInputs = [ perl_MathInt64 ];

  meta = {
    homepage = http://metacpan.org/release/Math-Int128;
    description = "Manipulate 128 bits integers in Perl";
    license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
