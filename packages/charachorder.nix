{ buildPythonPackage
, fetchFromGitHub
, lib
, pythonOlder

  # dependencies
, pyserial
}:

buildPythonPackage rec {
  pname = "charachorder";
  version = "0.1.1";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "GetPsyched";
    repo = "charachorder.py";
    rev = "v${version}";
    sha256 = "sha256-LQ1Nyd3LYnQ6J1HLGP2L0+GEcuezKqm7hVVDDBSP43g=";
  };

  nativeBuildInputs = [ pyserial ];

  meta = with lib; {
    description = "A wrapper for CharaChorder's Serial API written in Python";
    downloadPage = "https://github.com/GetPsyched/charachorder.py/releases/tag/v${version}";
    homepage = "https://github.com/GetPsyched/charachorder.py/";
    license = licenses.mit;
    maintainers = [ maintainers.getpsyched ];
    platforms = platforms.all;
    sourceProvenance = [ sourceTypes.fromSource ];
  };
}
