{ stdenv, buildPerlPackage, fetchurl }:

# nix-generate-from-cpan
buildPerlPackage rec {
  name = "Scalar-List-Utils-1.47";
  src = fetchurl {
    url = "mirror://cpan/authors/id/P/PE/PEVANS/${name}.tar.gz";
    sha256 = "c483347372a96972d61fd186522a9dafc2da899ef2951964513b7e8efb37efe1";
  };

  meta = {
    description = "Common Scalar and List utility subroutines";
    license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
