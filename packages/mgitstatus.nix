{ fetchFromGitHub, stdenv }:

stdenv.mkDerivation rec {
  pname = "mgitstatus";
  version = "2.2";

  src = fetchFromGitHub {
    owner = "fboender";
    repo = "multi-git-status";
    rev = version;
    hash = "sha256-jzoX7Efq9+1UdXQdhLRqBlhU3cBrk5AZblg9AYetItg=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/man/man1
    install -m 755 mgitstatus $out/bin/${pname}
    install mgitstatus.1 $out/man/man1

    runHook postInstall
  '';

  meta = with lib; {
    description = "Show uncommitted, untracked and unpushed changes for multiple Git repos";
    downloadPage = "https://github.com/fboender/multi-git-status/releases/tag/v${version}";
    homepage = "https://github.com/fboender/multi-git-status";
    license = licenses.mit;
    maintainers = [ maintainers.getpsyched ];
    platforms = platforms.all;
    sourceProvenance = [ sourceTypes.fromSource ];
  };
}
