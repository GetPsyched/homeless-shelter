{ buildPythonPackage, fetchPypi, lib, pythonOlder }:

buildPythonPackage rec {
  pname = "fluent-pygments";
  version = "1.0";
  format = "wheel";

  disabled = pythonOlder "3.5";

  src = fetchPypi rec {
    inherit version format;
    pname = "fluent.pygments";
    hash = "sha256-YlyHqKI2LvMEFGsWHTWdz2Ur7Soa5IabVge44G0RfZc=";
    dist = python;
    python = "py2.py3";
  };

  meta = with lib; {
    description = "Pygments lexer for Fluent";
    homepage = "https://github.com/projectfluent/python-fluent";
    changelog = "https://github.com/projectfluent/python-fluent/blob/main/fluent.pygments/CHANGELOG.rst";
    license = licenses.asl20;
    maintainers = with maintainers; [ getpsyched ];
  };
}
