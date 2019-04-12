{ stdenv, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  name = "Devel-Refcount-0.10";
  src = fetchurl {
    url = "mirror://cpan/authors/id/P/PE/PEVANS/${name}.tar.gz";
    sha256 = "b654d46963d1a881426ba15994f28f52eb839b0d135bf239b4d1bf38b1caca4a";
  };

  buildInputs = with perlPackages; [ ModuleBuild TestFatal ];

  meta = {
    description = "Obtain the REFCNT value of a referent";
    license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
