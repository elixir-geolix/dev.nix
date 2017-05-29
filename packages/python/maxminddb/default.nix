{ stdenv, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  pname   = "maxminddb";
  version = "1.3.0";
  name    = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "1gn4pc143pi8xd9cq2b1xz2i326ics94ilpji5wbnk4bs2v9j8wp";
  };

  propagatedBuildInputs = with pythonPackages; [ ipaddress ];
}
