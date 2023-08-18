{ lib
, python311
, fetchFromGitHub

  # dependencies
, pynput
, pyside6
, setuptools

  # tests
, flake8
, pytest
, pytest-cov
}:

python311.pkgs.buildPythonApplication rec {
  pname = "nexus";
  version = "0.2.3";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "CharaChorder";
    repo = "nexus";
    rev = "v${version}";
    sha256 = "sha256-2Itr9Jb7yL9aL5iAt6fS+1aUQ83V00OVKgVqXan9XbI=";
  };

  propagatedBuildInputs = [
    pynput
    pyside6
    setuptools
  ];

  nativeCheckInputs = [
    flake8
    pytest
    pytest-cov
  ];

  # FIXME: this patches a display error. needs xwayland
  doCheck = false;

  checkPhase = ''
    runHook preCheck

    pytest

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
