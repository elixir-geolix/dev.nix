{ stdenv, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  name = "Sub-Quote-2.003001";
  src  = fetchurl {
    url    = "mirror://cpan/authors/id/H/HA/HAARG/${name}.tar.gz";
    sha256 = "9d471d8e13e7ce4793d5a5ec04a60fface14dd53be78dd94d228871915cfd1f9";
  };

  buildInputs = with perlPackages; [ TestFatal ];

  meta = {
    description = "Efficient generation of subroutines via string eval";
    license     = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
