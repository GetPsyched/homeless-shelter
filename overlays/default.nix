{ inputs, lib, ... }:
{
  additions = final: _prev: import ../packages { pkgs = final; };

  modifications = final: prev: {
    citrix_workspace =
      (import inputs.nixpkgs-citrix {
        inherit (final) config;
        inherit (final.stdenv.hostPlatform) system;
      }).citrix_workspace;

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
        rm $out/lib/firefox/browser/omni.ja

        sed -i 's/"enterprise_only"\s*:\s*true,//' patched_omni/modules/policies/schema.sys.mjs

        cd patched_omni
        ${lib.getExe prev.zip} -0 --recurse-paths --no-dir-entries -X --quiet $out/lib/firefox/browser/omni.ja *
        cd .. && rm -r patched_omni
        popd
      '';
    });

    # Pin to fix winboat
    # https://github.com/NixOS/nixpkgs/issues/462513
    nodejs_24 = prev.nodejs_24.overrideAttrs (old: rec {
      version = "24.11.0";
      src = prev.fetchurl {
        url = "https://nodejs.org/dist/v${version}/node-v${version}.tar.xz";
        hash = "sha256-z5yQbUZEZHH5VbHyxqzopGFQHYLSfhroWV3LOw4sMSo=";
      };
    });
  };
}
