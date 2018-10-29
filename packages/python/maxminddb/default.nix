{ stdenv, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  pname   = "maxminddb";
  version = "1.4.1";
  name    = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "04mpilsj76m29id5xfi8mmasdmh27ldn7r0dmh2rj6a8v2y5256z";
  };

  buildInputs = with pythonPackages; [
    mock
    nose
  ];

  propagatedBuildInputs = with pythonPackages; [
    ipaddress
    requests-mock
  ];
}
