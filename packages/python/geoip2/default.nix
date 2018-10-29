{ stdenv, pkgs, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  python_maxminddb = pkgs.callPackage ../maxminddb { inherit pythonPackages; };

  pname   = "geoip2";
  version = "2.9.0";
  name    = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "1w7cay5q6zawjzivqbwz5cqx1qbdjw6kbriccb7l46p7b39fkzzp";
  };

  propagatedBuildInputs = with pythonPackages; [
    python_maxminddb

    requests
  ];
}
