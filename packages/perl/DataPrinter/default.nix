{ stdenv, pkgs, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  perl_ClonePP = pkgs.callPackage ../ClonePP {};

  name = "Data-Printer-0.39";
  src  = fetchurl {
    url    = "mirror://cpan/authors/id/G/GA/GARU/${name}.tar.gz";
    sha256 = "269848343a5ef40ea5059755d1012862d29f211d62937a5c1a73bfac76226499";
  };

  propagatedBuildInputs = with perlPackages; [
    perl_ClonePP

    FileHomeDir PackageStash SortNaturally
  ];

  meta = {
    description = "Colored pretty-print of Perl data structures and objects";
    license     = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
