{ buildPythonPackage
, fetchFromGitHub
, lib
, pythonOlder
}:

buildPythonPackage rec {
  pname = "charachorder";
  version = "0.1.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "GetPsyched";
    repo = "charachorder.py";
    rev = "v${version}";
    sha256 = "sha256-espkzhfI4IJhN6Hdva5pgcXHVHiIK9swCuut11IdV7E=";
  };

  disabled = pythonOlder "3.8";

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
