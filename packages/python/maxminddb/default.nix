{ stdenv, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  pname = "maxminddb";
  version = "2.0.1";
  name = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "0j489vqbhp92rz5ysbg4vpf1gz7ll32mi7hf7im9l8l87d646hpd";
  };

  propagatedBuildInputs = with pythonPackages; [
    ipaddress
  ];

  doCheck = false;
}
