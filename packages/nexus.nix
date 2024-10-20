{
  buildPythonApplication,
  copyDesktopItems,
  fetchFromGitHub,
  lib,
  makeDesktopItem,
  python,
  pythonOlder,

  # dependencies
  cryptography,
  pynput,
  pyside6-essentials,
  pyserial,
  requests,
  setuptools,

  # tests
  flake8,
  pytest,
  pytest-cov,
  xvfb-run,
}:

let
  pname = "nexus";
  version = "0.5.1";
in
buildPythonApplication {
  inherit pname version;
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "CharaChorder";
    repo = "nexus";
    rev = "v${version}";
    sha256 = "sha256-Db9XNFRlJ7HgAt57dn2Yhy4HByw9nuQW41oj+4aOPQ0=";
  };

  disabled = pythonOlder "3.11";

  nativeBuildInputs = [ copyDesktopItems ];

  dependencies = [
    cryptography
    pynput
    pyside6-essentials
    pyserial
    requests
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
      pyside6-uic = lib.getExe' pyside6-essentials "pyside6-uic";
      pyside6-rcc = lib.getExe' pyside6-essentials "pyside6-rcc";
      pyside6-lupdate = lib.getExe' pyside6-essentials "pyside6-lupdate";
      pyside6-lrelease = lib.getExe' pyside6-essentials "pyside6-lrelease";

      sitePackages = "$out/${python.sitePackages}";
      packageDir = "${sitePackages}/${pname}";
    in
    ''
      mkdir -p ${packageDir}/{translations,ui}

      for file in ui/*.ui; do
        NEW_NAME=$(echo $file | cut --delimiter="." --fields=1).py
        ${pyside6-uic} $file -o ${packageDir}/$NEW_NAME
      done

      mkdir ${sitePackages}/resources_rc
      ${pyside6-rcc} ui/resources.qrc -o ${sitePackages}/resources_rc/__init__.py

      ${pyside6-lupdate} ui/*.ui nexus/GUI.py -ts translations/i18n_en.ts
      for file in translations/*.ts; do
        NEW_NAME=$(echo $file | cut --delimiter="." --fields=1).qm
        ${pyside6-lrelease} $file -qm ${packageDir}/$NEW_NAME
      done
    '';

  postInstall = ''
    install -D -m444 ui/images/icon.svg $out/share/icons/hicolor/scalable/apps/${pname}.svg
  '';

  checkPhase = ''
    runHook preCheck

    # The following line tries to access the filesystem:
    # https://github.com/CharaChorder/nexus/blob/v0.5.1/nexus/Freqlog/Definitions.py#L41
    # Imported here:
    # https://github.com/CharaChorder/nexus/blob/v0.5.1/tests/Freqlog/backends/SQLite/test_SQLiteBackend.py#L6
    export HOME=$TMPDIR

    xvfb-run pytest

    runHook postCheck
  '';

  desktopItems = [
    (makeDesktopItem {
      comment = "CharaChorder's logging and analysis desktop app";
      desktopName = "Nexus";
      exec = "nexus";
      icon = pname;
      name = pname;
      startupNotify = true;
      startupWMClass = pname;
      terminal = false;
      type = "Application";
    })
  ];

  meta = {
    description = "CharaChorder's all-in-one desktop app";
    downloadPage = "https://github.com/CharaChorder/nexus/releases/tag/v${version}";
    homepage = "https://github.com/CharaChorder/nexus/";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ getpsyched ];
    mainProgram = "nexus";
    platforms = lib.platforms.linux;
    sourceProvenance = [ lib.sourceTypes.fromSource ];
  };
}
