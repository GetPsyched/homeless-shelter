{ buildPythonApplication
, copyDesktopItems
, fetchFromGitHub
, lib
, makeDesktopItem
, pythonOlder

  # dependencies
, cryptography
, pynput
, pyside6-essentials
, pyserial
, setuptools

  # tests
, flake8
, pytest
, pytest-cov
, xvfb-run
}:

buildPythonApplication rec {
  pname = "nexus";
  version = "0.5.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "CharaChorder";
    repo = "nexus";
    rev = "v${version}";
    sha256 = "sha256-12+YotcD/f9THqarraaeYLUih7csN2R+h6A5iDRNDNg=";
  };

  disabled = pythonOlder "3.11";

  nativeBuildInputs = [ copyDesktopItems ];

  propagatedBuildInputs = [
    cryptography
    pynput
    pyside6-essentials
    pyserial
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
      pyside6-uic = "${pyside6-essentials}/bin/pyside6-uic";
      pyside6-rcc = "${pyside6-essentials}/bin/pyside6-rcc";
      pyside6-lupdate = "${pyside6-essentials}/bin/pyside6-lupdate";
      pyside6-lrelease = "${pyside6-essentials}/bin/pyside6-lrelease";
    in
    ''
      for file in ui/*.ui; do
        NEW_NAME=$(echo $file | cut --delimiter="." --fields=1).py
        ${pyside6-uic} $file -o src/nexus/$NEW_NAME
      done

      ${pyside6-rcc} ui/resources.qrc -o src/resources_rc.py

      ${pyside6-lupdate} ui/*.ui src/nexus/GUI.py -ts translations/i18n_en.ts

      mkdir -p src/nexus/translations
      ${pyside6-lrelease} translations/i18n_en.ts -qm src/nexus/translations/i18n_en.qm
      ${pyside6-lrelease} translations/i18n_ro.ts -qm src/nexus/translations/i18n_ro.qm
    '';

  postInstall = ''
    mkdir -p $out/share/icons/hicolor/scalable/apps
    cp ui/images/icon.svg $out/share/icons/hicolor/scalable/apps/${pname}.svg

    # hacks ahead, do not touch
    mv -v src/nexus/translations $out/lib/python3.11/site-packages/${pname}
    mv -v src/nexus/ui $out/lib/python3.11/site-packages/${pname}
    mkdir $out/lib/python3.11/site-packages/resources_rc
    mv -v src/resources_rc.py $out/lib/python3.11/site-packages/resources_rc/__main__.py
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
    mainProgram = pname;
    platforms = platforms.linux;
    sourceProvenance = [ sourceTypes.fromSource ];
  };
}
