{ fetchFromGitHub, lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "neuron";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "GetPsyched";
    repo = pname;
    rev = "e4d76ec";
    hash = "sha256-j8ADtSByLB0NBNgpOPfe2V0yNHiqebqgRwoRCGl1AQc=";
  };

  cargoHash = "sha256-m1Te+nRQv9FKt1T5CjDjuezQSZ0u72wjhx1y68a5JQc=";

  meta = with lib; {
    description = "Hack your brain with neuron";
    homepage = "https://github.com/GetPsyched/neuron";
    license = licenses.gpl3Only;
    maintainers = [ maintainers.getpsyched ];
  };
}
