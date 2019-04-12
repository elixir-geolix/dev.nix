{ stdenv, buildPerlPackage, fetchurl, perlPackages }:

# nix-generate-from-cpan
buildPerlPackage rec {
  name = "Lexical-SealRequireHints-0.010";
  src = fetchurl {
    url = "mirror://cpan/authors/id/Z/ZE/ZEFRAM/${name}.tar.gz";
    sha256 = "e975b0f4296fe379accda73c8775435986128dac8ad8864f4694ddecd715a134";
  };

  buildInputs = with perlPackages; [ ModuleBuild ];

  meta = {
    description = "Prevent leakage of lexical hints";
    license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
