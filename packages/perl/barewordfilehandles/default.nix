{ stdenv, pkgs, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  perl_LexicalSealRequireHints = pkgs.callPackage ../LexicalSealRequireHints {};

  name = "bareword-filehandles-0.005";
  src = fetchurl {
    url = "mirror://cpan/authors/id/I/IL/ILMARI/${name}.tar.gz";
    sha256 = "66ab8cf4118187c2abc8178389007cd0f836702aff7fbaab37edbc2b34cdb139";
  };

  buildInputs = with perlPackages; [ ExtUtilsDepends ];

  propagatedBuildInputs = with perlPackages; [
    perl_LexicalSealRequireHints

    BHooksOPCheck
  ];

  meta = {
    homepage = https://github.com/ilmari/bareword-filehandles;
    description = "Disables bareword filehandles";
    license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
