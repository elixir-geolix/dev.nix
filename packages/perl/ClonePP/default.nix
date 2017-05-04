{ stdenv, pkgs, buildPerlPackage, fetchurl }:

# nix-generate-from-cpan
buildPerlPackage rec {
  name = "Clone-PP-1.07";
  src  = fetchurl {
    url    = "mirror://cpan/authors/id/N/NE/NEILB/${name}.tar.gz";
    sha256 = "bf85e109b7d9a10677db82fa65c1720ae95499a49cbb676d4b3d1b183786b395";
  };

  buildInputs = with pkgs; [ perl ];

  meta = {
    license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
