{ aiohttp, buildPythonPackage, fetchPypi, lib, pythonOlder }:

buildPythonPackage rec {
  pname = "fluent-syntax";
  version = "0.19.0";
  format = "wheel";

  disabled = pythonOlder "3.6";

  src = fetchPypi rec {
    inherit version format;
    pname = "fluent.syntax";
    hash = "sha256-s1KzR1+sbG7V8GUnkh9DKqwHPXZERVCO5SGK7Mx8xcQ=";
    dist = python;
    python = "py2.py3";
  };

  propagatedBuildInputs = [
    aiohttp
  ];

  meta = with lib; {
    description = "Localization library for expressive translations";
    homepage = "https://github.com/projectfluent/python-fluent";
    changelog = "https://github.com/projectfluent/python-fluent/blob/main/fluent.syntax/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ getpsyched ];
  };
}
