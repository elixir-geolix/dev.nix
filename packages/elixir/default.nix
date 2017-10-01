{ stdenv, fetchFromGitHub, erlang, rebar, makeWrapper, coreutils, curl, bash,
  debugInfo ? false }:

stdenv.mkDerivation rec {
  name = "elixir-${version}";
  version = "1.3.4";

  src = fetchFromGitHub {
    owner = "elixir-lang";
    repo = "elixir";
    rev = "v${version}";
    sha256 = "01qqv1ghvfadcwcr5p88w8j217cgaf094pmpqllij3l0q1yg104l";
  };

  buildInputs = [ erlang rebar makeWrapper ];

  # Elixir expects that UTF-8 locale to be set (see https://github.com/elixir-lang/elixir/issues/3548).
  # In other cases there is warnings during compilation.
  LANG = "en_US.UTF-8";
  LC_TYPE = "en_US.UTF-8";

  setupHook = ./setup-hook.sh;

  inherit debugInfo;

  buildFlags = if debugInfo
   then "ERL_COMPILER_OPTIONS=debug_info"
   else "";

  preBuild = ''
    # The build process uses ./rebar. Link it to the nixpkgs rebar
    rm -v rebar
    ln -s ${rebar}/bin/rebar rebar

    substituteInPlace Makefile \
      --replace "/usr/local" $out
  '';

  postFixup = ''
    # Elixir binaries are shell scripts which run erl. Add some stuff
    # to PATH so the scripts can run without problems.

    for f in $out/bin/*; do
     b=$(basename $f)
      if [ $b == "mix" ]; then continue; fi
      wrapProgram $f \
        --prefix PATH ":" "${stdenv.lib.makeBinPath [ erlang coreutils curl bash ]}" \
        --set CURL_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt
    done

    substituteInPlace $out/bin/mix \
          --replace "/usr/bin/env elixir" "${coreutils}/bin/env elixir"
  '';
}
