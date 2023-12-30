{ fetchFromGitHub, lib, stdenv }:

stdenv.mkDerivation (finalAttrs: {
  pname = "mgitstatus";
  version = "2.2";

  src = fetchFromGitHub {
    owner = "fboender";
    repo = "multi-git-status";
    rev = finalAttrs.version;
    hash = "sha256-jzoX7Efq9+1UdXQdhLRqBlhU3cBrk5AZblg9AYetItg=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm 755 mgitstatus $out/bin/${finalAttrs.pname}
    install -Dm 644 mgitstatus.1 $out/share/man/man1/${finalAttrs.pname}.1

    runHook postInstall
  '';

  meta = with lib; {
    description = "Show uncommitted, untracked and unpushed changes for multiple Git repos";
    downloadPage = "https://github.com/fboender/multi-git-status/releases/tag/v${finalAttrs.version}";
    homepage = "https://github.com/fboender/multi-git-status";
    license = licenses.mit;
    maintainers = [ maintainers.getpsyched ];
    mainProgram = finalAttrs.pname;
    platforms = platforms.all;
  };
})
