{ stdenv, pkgs, buildPerlPackage, fetchurl }:

# nix-generate-from-cpan
buildPerlPackage rec {
  perl_TestBits = pkgs.callPackage ../TestBits {};

  name = "Data-IEEE754-0.02";
  src = fetchurl {
    url = "mirror://cpan/authors/id/M/MA/MAXMIND/${name}.tar.gz";
    sha256 = "c6f4ab134672823413b50f07479b1a1b051f4cee42dd3ce7eb1583d6691b671d";
  };

  buildInputs = [ perl_TestBits ];

  meta = {
    homepage = http://metacpan.org/release/Data-IEEE754;
    description = "Pack and unpack big-endian IEEE754 floats and doubles";
    license = stdenv.lib.licenses.artistic2;
  };
}
