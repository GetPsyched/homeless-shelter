{ lib, ... }:
{
  additions = final: _prev: import ../packages { pkgs = final; };

  modifications = final: prev: {
    firefox = prev.firefox.overrideAttrs (
      old:
      let
        omniPath =
          if final.stdenv.hostPlatform.isDarwin then
            "$out/Applications/Firefox.app/Contents/Resources/browser/omni.ja"
          else
            "$out/lib/firefox/browser/omni.ja";
      in
      {
        buildCommand = ''
          export buildRoot="$(pwd)"

          ${old.buildCommand}

          pushd $buildRoot
          ${lib.getExe prev.unzip} "${omniPath}" -d patched_omni || ret=$?
          if [[ $ret && $ret -ne 2 ]]; then
            echo "unzip exited with unexpected error"
            exit $ret
          fi
          rm "${omniPath}"

          sed -i 's/"enterprise_only"\s*:\s*true,//' patched_omni/modules/policies/schema.sys.mjs

          cd patched_omni
          ${lib.getExe prev.zip} -0 --recurse-paths --no-dir-entries -X --quiet "${omniPath}" *
          cd .. && rm -r patched_omni
          popd
        '';
      }
    );
  };
}
