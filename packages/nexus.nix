{ lib
, pkgs
, python311
, fetchFromGitHub

  # dependencies
, pynput
, pyside6-essentials
, setuptools

  # tests
, flake8
, pytest
, pytest-cov
, xvfb-run
}:

let
  pyside2 = pkgs.python310Packages.pyside2;
  pyside2-tools = pkgs.python310Packages.pyside2-tools;
in
python311.pkgs.buildPythonApplication rec {
  pname = "nexus";
  version = "0.2.3";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "CharaChorder";
    repo = "nexus";
    rev = "2fb3c1c";
    sha256 = "sha256-QDe7fMtcMluxyfQiCa7HnuyDlHkuDSvctlQJ8pj+L7U=";
  };

  nativeBuildInputs = [
    pyside2
    pyside2-tools
  ];

  propagatedBuildInputs = [
    pynput
    pyside6-essentials
    setuptools
  ];

  nativeCheckInputs = [
    flake8
    pytest
    pytest-cov
    xvfb-run
  ];

  preBuild = ''
    ${pyside6-essentials}/bin/pyside6-uic ui/MainWindow.ui -o src/nexus/ui/MainWindow.py
    ${pyside6-essentials}/bin/pyside6-uic ui/BanlistDialog.ui -o src/nexus/ui/BanlistDialog.py
    ${pyside6-essentials}/bin/pyside6-uic ui/BanwordDialog.ui -o src/nexus/ui/BanwordDialog.py

    ${pyside6-essentials}/bin/pyside6-lupdate \
      ui/MainWindow.ui \
      ui/BanlistDialog.ui \
      ui/BanwordDialog.ui \
      src/nexus/GUI.py \
      -ts translations/i18n_en.ts
  '';

  postInstall = ''
    ls $out/lib/python3.11/site-packages
    mv -v src/nexus/ui $out/lib/python3.11/site-packages/${pname}
  '';

  checkPhase = ''
    runHook preCheck

    xvfb-run pytest

    runHook postCheck
  '';

  meta = with lib; {
    description = "CharaChorder's all-in-one desktop app";
    downloadPage = "https://github.com/CharaChorder/nexus/releases/tag/v${version}";
    homepage = "https://github.com/CharaChorder/nexus/";
    license = licenses.agpl3Only;
    maintainers = [ maintainers.getpsyched ];
    platforms = platforms.all;
  };
}
