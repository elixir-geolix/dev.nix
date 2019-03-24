with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "nix-shell-geolix";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    SHELL_LOCK="$PROJECT_ROOT/runtime/shell.lock"
    SHELL_NAME="geolix"

    function finish {
      rm -f "$SHELL_LOCK"
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      trap finish EXIT
    fi

    export SHELL_DATA_DIR="$(pwd)/runtime"

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[$SHELL_NAME|\[\e[1m\]\w\[\e[0m\]]$ "
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
