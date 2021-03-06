{ pkgs, stdenv, fetchFromGitHub, postgresql }:

stdenv.mkDerivation rec {
  name = "postgresql_ip4r-${version}";
  version = "2.4.1";

  src = fetchFromGitHub {
    owner = "RhodiumToad";
    repo = "ip4r";
    rev = version;
    sha256 = "1rnjmqhzkzkj9phbhvkw1rcf7q9f5w6mwihwdz2p2jqh90pbfqmj";
  };

  buildInputs = [ postgresql ];

  preConfigure = ''
    makeFlags="datadir=$out/share/postgresql docdir=$out/share/doc pkglibdir=$out/lib"
  '';

  installPhase = ''
    install -D ip4r.so -t $out/lib
    install -D scripts/ip4r--2.4.sql -t $out/share/postgresql/extension
    install -D ip4r.control -t $out/share/postgresql/extension
  '';
}
