with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "nix-shell-geolix";
  env  = buildEnv {
    name  = name;
    paths = buildInputs;
  };

  shellHook = ''
    PROJECT_ROOT="$(pwd)"
    LOG_POSTGRESQL="$PROJECT_ROOT/runtime/postgresql/postgresql.log"
    SHELL_LOCK="$PROJECT_ROOT/runtime/shell.lock"
    SHELL_NAME="geolix"

    function finish {
      pg_ctl stop

      rm -f "$SHELL_LOCK"
    }

    function configure_postgresql {
      createuser -s postgres

      psql -U postgres -c 'CREATE DATABASE geolix;'
      psql -U postgres -c 'CREATE USER geolix;'
      psql -U postgres -c "ALTER USER geolix PASSWORD 'geolix';"
      psql -U postgres -c 'GRANT ALL PRIVILEGES ON DATABASE geolix TO geolix;'
    }

    function setup_postgresql {
      mkdir -p runtime/postgresql
      initdb runtime/postgresql

      sed "s|{{PATH_PROJECT}}|$PROJECT_ROOT|g" \
          runtime/etc/postgresql.conf \
      > runtime/postgresql/postgresql.conf
    }

    export PGDATA="$PROJECT_ROOT/runtime/postgresql"

    if [ ! -f "$SHELL_LOCK" ]; then
      touch "$SHELL_LOCK"

      SHELL_NAME="$SHELL_NAME|\[\e[1m\]master\[\e[0m\]"

      setup_postgresql

      pg_ctl start -w \
          -D "$PROJECT_ROOT/runtime/postgresql" \
          -l "$LOG_POSTGRESQL"

      configure_postgresql

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

    postgresql
  ];
}
