{ buildGoModule, fetchFromGitHub, lib, sqlc }:

buildGoModule rec {
  pname = "breadboard";
  name = pname;

  src = fetchFromGitHub {
    owner = "nkss-dev";
    repo = pname;
    rev = "6b461c1";
    sha256 = "sha256-c5fRf7KmzN53GasMFUYlMUxegnSIKJ5Vl1fpSBZ7TLA=";
  };

  vendorHash = "sha256-XzQMEs87UdOjdKtq1Jw93v6lLUDw5KetmdRnOaMlU+4=";

  nativeBuildInputs = [ sqlc ];

  buildPhase = ''
    sqlc generate
  '';

  meta = with lib; {
    description = "A wrapper for the NKSS database";
    homepage = "https://github.com/nkss-dev/breadboard";
    license = licenses.mit;
    maintainers = [ maintainers.getpsyched ];
    sourceProvenance = [ sourceTypes.fromSource ];
  };
}
