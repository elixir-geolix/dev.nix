{ stdenv, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  name = "Test-HexDifferences-1.000";
  src = fetchurl {
    url = "mirror://cpan/authors/id/S/ST/STEFFENW/${name}.tar.gz";
    sha256 = "c9cc863f8c88b251a8cf80c7f30ec77b71a350a64179e72fc02bbbac12c952d9";
  };

  buildInputs = with perlPackages; [
    ModuleBuild TestDifferences TestNoWarnings 
  ];

  propagatedBuildInputs = with perlPackages; [ SubExporter TextDiff ];

  meta = {
    description = "Test::HexDifferences - Test binary as hexadecimal string";
    license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
