{ lib, ... }:
{
  additions = final: _prev: import ../packages { pkgs = final; };

  modifications = final: prev: {
    firefox = prev.firefox.overrideAttrs (old: {
      buildCommand = ''
        export buildRoot="$(pwd)"

        ${old.buildCommand}

        pushd $buildRoot
        ${lib.getExe prev.unzip} $out/lib/firefox/browser/omni.ja -d patched_omni || ret=$?
        if [[ $ret && $ret -ne 2 ]]; then
          echo "unzip exited with unexpected error"
          exit $ret
        fi

        sed -i 's/"enterprise_only"\s*:\s*true,//' patched_omni/modules/policies/schema.sys.mjs

        rm $out/lib/firefox/browser/omni.ja
        ${lib.getExe prev.zip} -0DXqr $out/lib/firefox/browser/omni.ja patched_omni/*
        popd
      '';
    });
  };
}
