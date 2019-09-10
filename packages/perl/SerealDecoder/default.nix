{ stdenv, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  pname = "Sereal-Decoder";
  version = "4.005";

  src = fetchurl {
    url = "mirror://cpan/authors/id/Y/YV/YVES/${pname}-${version}.tar.gz";
    sha256 = "17syqbq17qw6ajg3w88q9ljdm4c2b7zadq9pwshxxgyijg8dlfh4";
  };

  buildInputs = with perlPackages; [ TestLongString TestWarn ];

  meta = {
    description = "Fast, compact, powerful binary deserialization";
    license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
