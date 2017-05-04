{ stdenv, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  name = "Test-Bits-0.02";
  src  = fetchurl {
    url    = "mirror://cpan/authors/id/D/DR/DROLSKY/${name}.tar.gz";
    sha256 = "a9826f56483a27e2c63156590f328a3633e30375c10dfc89f6690e3929de0bc3";
  };

  buildInputs = with perlPackages; [ TestFatal ];

  propagatedBuildInputs = with perlPackages; [ ListAllUtils ];

  meta = {
    homepage    = http://metacpan.org/release/Test-Bits;
    description = "Provides a bits_is() subroutine for testing binary data";
    license     = stdenv.lib.licenses.artistic2;
  };
}
