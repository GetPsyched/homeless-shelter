{ lib
, pkgs
, python311
, fetchFromGitHub
, steam-run

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

  preBuild =
    let
      pyside6-uic = "${steam-run}/bin/steam-run ${pyside6-essentials}/bin/pyside6-uic";
      pyside6-lupdate = "${steam-run}/bin/steam-run ${pyside6-essentials}/bin/pyside6-lupdate";
      pyside6-lrelease = "${steam-run}/bin/steam-run ${pyside6-essentials}/bin/pyside6-lrelease";
    in
    ''
      ${pyside6-uic} ui/MainWindow.ui -o src/nexus/ui/MainWindow.py
      ${pyside6-uic} ui/BanlistDialog.ui -o src/nexus/ui/BanlistDialog.py
      ${pyside6-uic} ui/BanwordDialog.ui -o src/nexus/ui/BanwordDialog.py

      ${pyside6-lupdate} ui/*.ui src/nexus/GUI.py -ts translations/i18n_en.ts

      ${pyside6-lrelease} translations/i18n_en.ts -qm src/nexus/translations/i18n_en.qm
      ${pyside6-lrelease} translations/i18n_ro.ts -qm src/nexus/translations/i18n_ro.qm
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
