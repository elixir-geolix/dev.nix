with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "nix-shell-geolix";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    SHELL_LOCK="$PROJECT_ROOT/runtime/shell.lock"
    SHELL_NAME="geolix"

    function finish {
      pg_ctl \
          --pgdata="$PROJECT_ROOT/runtime/postgresql/data" \
          stop

      rm -f "$SHELL_LOCK"
    }

    function setup_postgres {
      [ -f runtime/postgresql/data/pg_hba.conf ] && return

      mkdir -p runtime/postgresql/data

      initdb \
          --pgdata="$PROJECT_ROOT/runtime/postgresql/data" \
          --pwfile="$PROJECT_ROOT/runtime/etc/postgresql.pwd" \
          --username="postgres" \
          --auth="md5" \
      >/dev/null
    }

    if [ ! -f "$SHELL_LOCK" ]; then
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      setup_postgres

      pg_ctl \
          --pgdata="$PROJECT_ROOT/runtime/postgresql/data" \
          --log="$PROJECT_ROOT/runtime/postgresql/postgresql.log" \
          -o "-p 5432" \
          start

      trap finish EXIT
    fi

    export SHELL_DATA_DIR="$(pwd)/runtime"

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[$SHELL_NAME|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  elixir = pkgs.callPackage ./packages/elixir {};
  geoip2_csv_converter = pkgs.callPackage ./packages/geoip2-csv-converter {};
  perl_MaxMindDBWriter = pkgs.callPackage ./packages/perl/MaxMindDBWriter {};
  postgresql_ip4r = pkgs.callPackage ./packages/postgresql/ip4r {};
  python3_geoip2 = pkgs.callPackage ./packages/python/geoip2 { pythonPackages = python3Packages; };

  buildInputs = [
    elixir

    geoip2_csv_converter

    perl
    perl_MaxMindDBWriter

    perlPackages.FileSlurper
    perlPackages.CpanelJSONXS

    python3
    python3_geoip2

    postgresql
  ];
}
