{ inputs, lib, ... }:
{
  additions = final: _prev: import ../packages { pkgs = final; };

  modifications = final: prev: {
    firefox = prev.firefox.overrideAttrs (old: {
      buildCommand =
        ''
          export buildRoot="$(pwd)"
        ''
        + old.buildCommand
        + ''
          pushd $buildRoot
          ${lib.getExe prev.unzip} $out/lib/firefox/browser/omni.ja -d patched_omni || ret=$?
          if [[ $ret && $ret -ne 2 ]]; then
            echo "unzip exited with unexpected error"
            exit $ret
          fi
          rm $out/lib/firefox/browser/omni.ja
          cd patched_omni
          sed -i 's/"enterprise_only"\s*:\s*true,//' modules/policies/schema.sys.mjs
          ${lib.getExe prev.zip} -0DXqr $out/lib/firefox/browser/omni.ja * # potentially qr9XD
          popd
        '';
    });

    logseq = inputs.nixpkgs-master.legacyPackages.${final.system}.logseq;
  };
}
