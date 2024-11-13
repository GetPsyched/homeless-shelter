{
  autoPatchelfHook,
  buildPythonPackage,
  fetchurl,
  lib,
  shiboken6,

  # libraries
  gtk3,
  libxkbcommon,
  mysql80,
  postgresql,
  qt6,
  unixODBC,
}:

buildPythonPackage {
  pname = "pyside6-essentials";
  inherit (shiboken6) version;
  format = "wheel";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/34/72/6ef2f32e5ae5681cdd10cc7e627c453fcd389889fbc6a76d4e400a27af87/PySide6_Essentials-${shiboken6.version}-cp39-abi3-manylinux_2_28_x86_64.whl";
    sha256 = "sha256-ffbWwdpIWNvep3x01ycNnGjo0bvjNiiSq9GlreOBWlA=";
  };

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

  dependencies = [
    shiboken6
  ];

  autoPatchelfIgnoreMissingDeps = [
    "libmimerapi.so"
    "libQt6EglFsKmsGbmSupport.so.6"
  ]; # not in nixpkgs yet

  meta = {
    description = "Minimal wheel for PySide6, it includes only the essentials Qt modules";
    homepage = "https://www.pyside.org";
    license = lib.licenses.lgpl3; # unsure which LGPL version
    maintainers = with lib.maintainers; [ getpsyched ];
  };
}
