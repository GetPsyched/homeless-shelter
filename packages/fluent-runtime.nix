{ aiohttp, attrs, babel, buildPythonPackage, fetchPypi, fluent-syntax, lib, pythonOlder, pytz }:

buildPythonPackage rec {
  pname = "fluent-runtime";
  version = "0.4.0";
  format = "wheel";

  disabled = pythonOlder "3.6";

  src = fetchPypi rec {
    inherit version format;
    pname = "fluent.runtime";
    hash = "sha256-Uf0CWCwjY+EQbXBRZClnobf0Bt2cMXvUYApz7eQMUUY=";
    dist = python;
    python = "py2.py3";
  };

  propagatedBuildInputs = [
    fluent-syntax
    aiohttp
    attrs
    babel
    pytz
  ];

  pythonImportsCheck = [
    "fluent.runtime"
  ];

  meta = with lib; {
    description = "Localization library for expressive translations";
    homepage = "https://github.com/projectfluent/python-fluent";
    changelog = "https://github.com/projectfluent/python-fluent/blob/main/fluent.runtime/CHANGELOG.rst";
    license = licenses.asl20;
    maintainers = with maintainers; [ getpsyched ];
  };
}
