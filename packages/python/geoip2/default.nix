{ stdenv, pkgs, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  python_maxminddb = pkgs.callPackage ../maxminddb { inherit pythonPackages; };

  pname   = "geoip2";
  version = "2.7.0";
  name    = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "0ia95hjxdk3pa631lyganysl6y5kki82d4hjynv12yv2pn3q551f";
  };

  propagatedBuildInputs = with pythonPackages; [
    python_maxminddb

    requests
  ];
}
