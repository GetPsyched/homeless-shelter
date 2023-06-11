{ fetchurl, jre, lib, makeWrapper, stdenv }:

stdenv.mkDerivation rec {
  pname = "atlauncher";
  version = "3.4.28.1";

  src = fetchurl {
    url = "https://github.com/ATLauncher/ATLauncher/releases/download/v${version}/ATLauncher-${version}.jar";
    sha256 = "sha256-IIwDMazxUMQ7nGQk/4VEZicgCmCR4oR8UYtO36pCEq4=";
  };

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    makeWrapper ${jre}/bin/java $out/bin/atlauncher \
      --add-flags "-jar $src --working-dir=\$HOME/.atlauncher"
    runHook postInstall
  '';

  meta = with lib; {
    description = "A simple and easy to use Minecraft launcher which contains many different modpacks for you to choose from and play";
    downloadPage = "https://atlauncher.com/downloads";
    homepage = "https://atlauncher.com/";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = [ maintainers.getpsyched ];
  };
}
