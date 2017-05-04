{ stdenv, pkgs, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  perl_SerealDecoder = pkgs.callPackage ../SerealDecoder {};

  name = "Sereal-Encoder-3.015";
  src  = fetchurl {
    url    = "mirror://cpan/authors/id/Y/YV/YVES/${name}.tar.gz";
    sha256 = "b7b2eb1dac6489308aa2c4dfa3ac31d3d9139bc1a126e4741d11991531440855";
  };

  buildInputs = with perlPackages; [
    perl_SerealDecoder

    TestLongString TestWarn
  ];

  meta = {
    description = "Fast, compact, powerful binary serialization";
    license     = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
