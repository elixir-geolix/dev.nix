{ stdenv, pkgs, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  perl_MathInt128 = pkgs.callPackage ../MathInt128 {};
  perl_SubQuote = pkgs.callPackage ../SubQuote {};

  pname = "Net-Works";
  version = "0.22";

  src = fetchurl {
    url = "mirror://cpan/authors/id/M/MA/MAXMIND/${pname}-${version}.tar.gz";
    sha256 = "0ac9b23dfbca184e28729b245394bc6693aadb6fc451caa995b4b719ec0ee9ff";
  };

  buildInputs = with perlPackages; [ TestFatal ];

  propagatedBuildInputs = with perlPackages; [
    perl_MathInt128
    perl_SubQuote

    ListAllUtils Moo namespaceautoclean
  ];

  meta = {
    description = "Sane APIs for IP addresses and networks";
    license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
