{ stdenv, pkgs, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  perl_ClonePP = pkgs.callPackage ../ClonePP {};

  name = "Data-Printer-0.40";
  src  = fetchurl {
    url    = "mirror://cpan/authors/id/G/GA/GARU/${name}.tar.gz";
    sha256 = "0njjh8zp5afc4602jrnmg89icj7gfsil6i955ypcqxc2gl830sb0";
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
