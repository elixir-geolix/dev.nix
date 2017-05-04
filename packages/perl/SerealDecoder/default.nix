{ stdenv, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  name = "Sereal-Decoder-3.015";
  src  = fetchurl {
    url    = "mirror://cpan/authors/id/Y/YV/YVES/${name}.tar.gz";
    sha256 = "235f68ea0354b80a5d8aa4d3ade312dfa100f9f3de54c101f0367eb691385b47";
  };

  buildInputs = with perlPackages; [ TestLongString TestWarn ];

  meta = {
    description = "Fast, compact, powerful binary deserialization";
    license     = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
