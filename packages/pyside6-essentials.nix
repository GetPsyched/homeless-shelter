{ buildPythonPackage, fetchurl, lib, shiboken6 }:

buildPythonPackage rec {
  pname = "pyside6-essentials";
  version = "6.6.0";
  format = "wheel";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/e2/f0/09e8e38a51f705eecda1202cb51a9fcc7affb0f9fd3be44bf58ce25528dc/PySide6_Essentials-6.6.0-cp38-abi3-manylinux_2_28_x86_64.whl";
    sha256 = "sha256-YChGQWGflk4ctNU88xadejheA3i3Ttt1YQkY0q6hxOU=";
  };

  propagatedBuildInputs = [
    shiboken6
  ];

  meta = with lib; {
    description = "This is a minimal wheel for PySide6, it includes only the essentials Qt modules";
    homepage = "https://www.pyside.org";
    license = licenses.lgpl3; # unsure which LGPL version
    maintainers = with maintainers; [ getpsyched ];
  };
}
