{ stdenv, pkgs, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  python_maxminddb = pkgs.callPackage ../maxminddb { inherit pythonPackages; };

  pname   = "geoip2";
  version = "2.5.0";
  name    = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "10659k4k00q1phww1d9pr8j2k2qamb0i134apmfnikr8q1qcbjkk";
  };

  propagatedBuildInputs = with pythonPackages; [
    python_maxminddb

    requests
  ];
}
