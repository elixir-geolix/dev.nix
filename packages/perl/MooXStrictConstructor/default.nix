{ stdenv, pkgs, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  perl_barewordfilehandles = pkgs.callPackage ../barewordfilehandles {};
  perl_indirect = pkgs.callPackage ../indirect {};
  perl_multidimensional  = pkgs.callPackage ../multidimensional {};

  name = "MooX-StrictConstructor-0.008";
  src  = fetchurl {
    url = "mirror://cpan/authors/id/H/HA/HARTZELL/${name}.tar.gz";
    sha256 = "bf1ff7b5d22e9fbaa37eafaa7bdef1997fbd853f1d893ebdcf75a360e67081ac";
  };

  buildInputs = with perlPackages; [
    ModuleBuild PodCoverageTrustPod
    TestCPANMeta TestFatal TestPod TestPodCoverage
  ];

  propagatedBuildInputs = with perlPackages; [
    perl_barewordfilehandles
    perl_indirect
    perl_multidimensional

    ClassMethodModifiers Moo
    strictures
  ];

  meta = {
    homepage = https://metacpan.org/release/MooX-StrictConstructor;
    description = "Make your Moo-based object constructors blow up on unknown attributes";
    license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
