{ stdenv, pkgs, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  perl_DataIEEE754 = pkgs.callPackage ../DataIEEE754 {};
  perl_DataPrinter = pkgs.callPackage ../DataPrinter {};
  perl_MathInt128 = pkgs.callPackage ../MathInt128 {};
  perl_MaxMindDBCommon = pkgs.callPackage ../MaxMindDBCommon {};
  perl_MooXStrictConstructor = pkgs.callPackage ../MooXStrictConstructor {};
  perl_ScalarUtil = pkgs.callPackage ../ScalarUtil {};
  perl_TestBits = pkgs.callPackage ../TestBits {};

  pname = "MaxMind-DB-Reader";
  version = "1.000014";

  src = fetchurl {
    url = "mirror://cpan/authors/id/M/MA/MAXMIND/${pname}-${version}.tar.gz";
    sha256 = "1a9rrvarw3q6378w3sqv632w36a9bsh0r90yfa49lzwnkj7hf81q";
  };

  buildInputs = with perlPackages; [
    perl_ScalarUtil
    perl_TestBits

    PathClass TestFatal TestNumberDelta TestRequires
  ];

  propagatedBuildInputs = with perlPackages; [
    perl_DataIEEE754
    perl_DataPrinter
    perl_MathInt128
    perl_MaxMindDBCommon
    perl_MooXStrictConstructor

    DataValidateIP DateTime ListAllUtils
    ModuleImplementation Moo RoleTiny
    namespaceautoclean
  ];

  meta = {
    homepage = http://metacpan.org/release/MaxMind-DB-Reader;
    description = "Read MaxMind DB files and look up IP addresses";
    license = stdenv.lib.licenses.artistic2;
  };
}
