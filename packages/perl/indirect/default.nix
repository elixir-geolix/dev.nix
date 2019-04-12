{ stdenv, pkgs, buildPerlPackage, fetchurl }:

# nix-generate-from-cpan
buildPerlPackage rec {
  name = "indirect-0.37";
  src = fetchurl {
    url = "mirror://cpan/authors/id/V/VP/VPIT/${name}.tar.gz";
    sha256 = "ada92a3edb04ffd882fb6b5b4f2324dc9f385c19afc78c37ef27fcb52798fba4";
  };

  buildInputs = with pkgs; [ perl ];

  meta = {
    homepage = http://search.cpan.org/dist/indirect/;
    description = "Lexically warn about using the indirect method call syntax";
    license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  };
}
