{ stdenv, pkgs, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  perl_MooXStrictConstructor = pkgs.callPackage ../MooXStrictConstructor {};
  perl_SubQuote = pkgs.callPackage ../SubQuote {};

  name = "MaxMind-DB-Common-0.040001";
  src = fetchurl {
    url = "mirror://cpan/authors/id/M/MA/MAXMIND/${name}.tar.gz";
    sha256 = "6bc6df4bd36300d07aa4a5f8198ae6694ca7e313c038109c88dbc3a997b21bd7";
  };

  propagatedBuildInputs = with perlPackages; [
    perl_MooXStrictConstructor
    perl_SubQuote

    DataDumperConcise DateTime ListAllUtils
    Moo namespaceautoclean
  ];

  meta = {
    homepage = http://metacpan.org/release/MaxMind-DB-Common/;
    description = "Code shared by the MaxMind DB reader and writer modules";
    license = stdenv.lib.licenses.artistic2;
  };
}
