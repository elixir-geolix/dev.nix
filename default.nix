with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "nix-shell-geolix";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    export PS1="[${name}:\w]$ "
  '';

  elixir = pkgs.callPackage ./packages/elixir {};

  perl_MaxMindDBWriter = pkgs.callPackage ./packages/perl/MaxMindDBWriter {};
  python2_geoip2       = pkgs.callPackage ./packages/python/geoip2 { pythonPackages = python2Packages; };

  buildInputs = [
    elixir

    perl
    perl_MaxMindDBWriter

    perlPackages.FileSlurper
    perlPackages.CpanelJSONXS

    python2
    python2_geoip2
  ];
}
