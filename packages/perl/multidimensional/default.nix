{ stdenv, pkgs, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  perl_LexicalSealRequireHints = pkgs.callPackage ../LexicalSealRequireHints {};

  name = "multidimensional-0.013";
  src  = fetchurl {
    url    = "mirror://cpan/authors/id/I/IL/ILMARI/${name}.tar.gz";
    sha256 = "3d20ce3e2307c3cfb13f2d53ad99bba6f87ea20b53f7ffebb4308d88ccfee50a";
  };

  buildInputs = with perlPackages; [ ExtUtilsDepends ];

  propagatedBuildInputs = with perlPackages; [
    perl_LexicalSealRequireHints

    BHooksOPCheck
  ];

  meta = {
    homepage    = https://github.com/ilmari/multidimensional;
    description = "Disables multidimensional array emulation";
    license     = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
