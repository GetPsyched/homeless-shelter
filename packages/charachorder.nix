{ buildPythonPackage
, fetchFromGitHub
, lib
, pythonOlder

  # dependencies
, pyserial
}:

buildPythonPackage rec {
  pname = "charachorder";
  version = "0.1.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "GetPsyched";
    repo = "charachorder.py";
    rev = "8660b57";
    sha256 = "sha256-9mDkqKlla68LuV2xlAr8CPIy1jQ9XygVpfFS0tmbp2c=";
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
