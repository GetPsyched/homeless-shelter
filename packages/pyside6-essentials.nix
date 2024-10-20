{ autoPatchelfHook
, buildPythonPackage
, fetchurl
, lib
, shiboken6

  # libraries
, gtk3
, libxkbcommon
, mysql80
, postgresql
, qt6
, unixODBC
}:

buildPythonPackage rec {
  pname = "pyside6-essentials";
  inherit (shiboken6) version;
  format = "wheel";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/9d/fd/17510a0abd503a904ce3b9f1af87385435cf9340fb79c020a53d3a8385a5/PySide6_Essentials-${version}.0-cp39-abi3-manylinux_2_28_x86_64.whl";
    sha256 = "sha256-2pmpSAZBbsHjhkJqR059HlFMHN+K0XHABTdvT2M+chY=";
  };

  propagatedBuildInputs = [
    shiboken6
  ];

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    gtk3 # libgtk-3.so.0 and more
    libxkbcommon # libxkbcommon.so.0
    mysql80 # libmysqlclient.so.21
    postgresql.lib # libpq.so.5
    qt6.full # libGL.so.1, and more
    unixODBC # libodbc.so.2
  ];

  autoPatchelfIgnoreMissingDeps = [ "libmimerapi.so" "libQt6EglFsKmsGbmSupport.so.6" ]; # not in nixpkgs yet

  meta = with lib; {
    description = "A minimal wheel for PySide6, it includes only the essentials Qt modules";
    homepage = "https://www.pyside.org";
    license = licenses.lgpl3; # unsure which LGPL version
    maintainers = with maintainers; [ getpsyched ];
  };
}
