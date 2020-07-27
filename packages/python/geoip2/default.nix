{ stdenv, pkgs, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  python_maxminddb = pkgs.callPackage ../maxminddb { inherit pythonPackages; };
  python_requests = pkgs.callPackage ../requests { inherit pythonPackages; };

  pname = "geoip2";
  version = "4.0.1";
  name = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "06z6b1apgdr4s14i24yz5ds99swh1vjmcsv2w6n4zy63v5mmznlm";
  };

  propagatedBuildInputs = with pythonPackages; [
    aiohttp

    python_requests
    python_maxminddb
  ];

  doCheck = false;
}
