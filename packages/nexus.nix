{ copyDesktopItems
, fetchFromGitHub
, lib
, makeDesktopItem
, pkgs
, python311
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
    rev = "88a5982";
    sha256 = "sha256-dGMpOl4QQBmEYuAKa3ywdn9NHM2MEW1QAHYCSXmcy1k=";
  };

  nativeBuildInputs = [ copyDesktopItems ];

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
      pyside6-rcc = "${steam-run}/bin/steam-run ${pyside6-essentials}/bin/pyside6-rcc";
      pyside6-lupdate = "${steam-run}/bin/steam-run ${pyside6-essentials}/bin/pyside6-lupdate";
      pyside6-lrelease = "${steam-run}/bin/steam-run ${pyside6-essentials}/bin/pyside6-lrelease";
    in
    ''
      ${pyside6-uic} ui/MainWindow.ui -o src/nexus/ui/MainWindow.py
      ${pyside6-uic} ui/BanlistDialog.ui -o src/nexus/ui/BanlistDialog.py
      ${pyside6-uic} ui/BanwordDialog.ui -o src/nexus/ui/BanwordDialog.py

      ${pyside6-rcc} ui/resources.qrc -o resources_rc.py

      ${pyside6-lupdate} ui/*.ui src/nexus/GUI.py -ts translations/i18n_en.ts

      mkdir -p src/nexus/translations
      ${pyside6-lrelease} translations/i18n_en.ts -qm src/nexus/translations/i18n_en.qm
      ${pyside6-lrelease} translations/i18n_ro.ts -qm src/nexus/translations/i18n_ro.qm
    '';

  postInstall = ''
    mkdir -p $out/share/icons/hicolor/scalable/apps
    cp ui/images/icon.svg $out/share/icons/hicolor/scalable/apps/${pname}.svg

    ls $out/lib/python3.11/site-packages
    mv -v src/nexus/ui $out/lib/python3.11/site-packages/${pname}
  '';

  checkPhase = ''
    runHook preCheck

    xvfb-run pytest

    runHook postCheck
  '';

  desktopItems = [
    (makeDesktopItem {
      comment = "CharaChorder's all-in-one desktop app";
      desktopName = "Nexus";
      exec = pname;
      icon = pname;
      name = pname;
      startupNotify = true;
      startupWMClass = pname;
      terminal = false;
      type = "Application";
    })
  ];

  meta = with lib; {
    description = "CharaChorder's all-in-one desktop app";
    downloadPage = "https://github.com/CharaChorder/nexus/releases/tag/v${version}";
    homepage = "https://github.com/CharaChorder/nexus/";
    license = licenses.agpl3Only;
    maintainers = [ maintainers.getpsyched ];
    platforms = platforms.all;
  };
}
