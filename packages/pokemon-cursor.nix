{ fetchurl, lib, stdenvNoCC }:

stdenvNoCC.mkDerivation rec {
  pname = "pokemon-cursor";
  version = "2.0.0";

  tar = fetchurl {
    url = "https://github.com/ful1e5/${pname}/releases/download/v${version}/Pokemon.tar.gz";
    sha256 = "sha256-Q8FPU9VixZ8WQgApVPFojc+6HF+RdLdDxg4lLZRLmyY=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/icons

    tar -xvf ${tar}
    mv Pokemon $out/share/icons
  '';

  meta = with lib; {
    description = "The Pokemon cursor";
    homepage = "https://github.com/ful1e5/pokemon-cursor";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ maintainers.getpsyched ];
  };
}
