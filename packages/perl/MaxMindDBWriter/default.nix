{ stdenv, pkgs, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  perl_DataIEEE754        = pkgs.callPackage ../DataIEEE754 {};
  perl_DataPrinter        = pkgs.callPackage ../DataPrinter {};
  perl_DevelRefcount      = pkgs.callPackage ../DevelRefcount {};
  perl_MathInt128         = pkgs.callPackage ../MathInt128 {};
  perl_MathInt64          = pkgs.callPackage ../MathInt64 {};
  perl_MaxMindDBCommon    = pkgs.callPackage ../MaxMindDBCommon {};
  perl_MaxMindDBReader    = pkgs.callPackage ../MaxMindDBReader {};
  perl_NetWorks           = pkgs.callPackage ../NetWorks {};
  perl_ScalarUtil         = pkgs.callPackage ../ScalarUtil {};
  perl_SerealDecoder      = pkgs.callPackage ../SerealDecoder {};
  perl_SerealEncoder      = pkgs.callPackage ../SerealEncoder {};
  perl_TestBits           = pkgs.callPackage ../TestBits {};
  perl_TestHexDifferences = pkgs.callPackage ../TestHexDifferences {};

  name = "MaxMind-DB-Writer-0.300001";
  src  = fetchurl {
    url    = "mirror://cpan/authors/id/M/MA/MAXMIND/${name}.tar.gz";
    sha256 = "0sas48fp9p96jdxnwh2dsw59sw63n7rxxdgs4zn9appjg25mm2ip";
  };

  configurePhase = "touch Makefile.PL";
  buildPhase     = "perl Build.PL --prefix=$out; ./Build build";
  installPhase   = "./Build install";
  checkPhase     = "./Build test";

  buildInputs = with perlPackages; [
    perl_DataPrinter
    perl_DevelRefcount
    perl_ScalarUtil
    perl_TestBits
    perl_TestHexDifferences

    JSON ListAllUtils ModuleBuild
    TestFatal TestRequires TestWarnings
  ];

  propagatedBuildInputs = with perlPackages; [
    perl_DataIEEE754
    perl_MathInt128
    perl_MathInt64
    perl_MaxMindDBCommon
    perl_MaxMindDBReader
    perl_NetWorks
    perl_SerealDecoder
    perl_SerealEncoder

    DataDumperConcise DigestSHA1
    Moose MooseXParamsValidate MooseXStrictConstructor
    TestDeep namespaceautoclean
  ];

  meta = {
    homepage    = http://metacpan.org/release/MaxMind-DB-Writer;
    description = "Create MaxMind DB database files";
    license     = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
