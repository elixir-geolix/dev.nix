{ stdenv, pkgs, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  perl_SerealDecoder = pkgs.callPackage ../SerealDecoder {};

  name = "Sereal-Encoder-4.005";
  src = fetchurl {
    url = "mirror://cpan/authors/id/Y/YV/YVES/${name}.tar.gz";
    sha256 = "02hbk5dwq7fpnyb3vp7xxhb41ra48xhghl13p9pjq9lzsqlb6l19";
  };

  buildInputs = with perlPackages; [
    perl_SerealDecoder

    TestLongString TestWarn
  ];

  meta = {
    description = "Fast, compact, powerful binary serialization";
    license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
