{ stdenv, pkgs, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  pname = "requests";
  version = "2.24.0";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "06r3017hz0hzxv42gpg73l8xvdjbzw7q904ljvp36b5p3l9rlmdk";
  };

  propagatedBuildInputs = with pythonPackages; [ urllib3 idna chardet certifi ];

  doCheck = false;
}