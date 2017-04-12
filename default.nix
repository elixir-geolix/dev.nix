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

  buildInputs = [
    elixir
  ];
}
