{ stdenv, pkgs, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  perl_DataIEEE754 = pkgs.callPackage ../DataIEEE754 {};
  perl_DataPrinter = pkgs.callPackage ../DataPrinter {};
  perl_MaxMindDBCommon = pkgs.callPackage ../MaxMindDBCommon {};
  perl_MooXStrictConstructor = pkgs.callPackage ../MooXStrictConstructor {};
  perl_ScalarUtil = pkgs.callPackage ../ScalarUtil {};
  perl_TestBits = pkgs.callPackage ../TestBits {};

  pname = "MaxMind-DB-Reader";
  version = "1.000013";

  src = fetchurl {
    url = "mirror://cpan/authors/id/M/MA/MAXMIND/${pname}-${version}.tar.gz";
    sha256 = "b8ce321cc94d71361edcf203af1bfd6ea0286fdd27b7550ecc5fad78a1abed70";
  };

  buildInputs = with perlPackages; [
    perl_ScalarUtil
    perl_TestBits

    PathClass TestFatal TestNumberDelta TestRequires
  ];

  propagatedBuildInputs = with perlPackages; [
    perl_DataIEEE754
    perl_DataPrinter
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
