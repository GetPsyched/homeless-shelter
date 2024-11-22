{ pkgs, ... }:
let
  buildFirefoxXpiAddon = pkgs.callPackage ./buildFirefoxXpiAddon.nix;
in
{
  darkreader = buildFirefoxXpiAddon rec {
    pname = "darkreader";
    version = "4.9.70";
    addonId = "addon@darkreader.org";
    url = "https://addons.mozilla.org/firefox/downloads/file/4198549/${pname}-${version}.xpi";
    sha256 = "sha256-PMviRwMd1PzD2b2ECHLtOOmENylwn5KAPCNAQQcFiKc=";
  };

  hoppscotch = buildFirefoxXpiAddon rec {
    pname = "hoppscotch";
    version = "0.25";
    addonId = "postwoman-firefox@postwoman.io";
    url = "https://addons.mozilla.org/firefox/downloads/file/3991522/${pname}-${version}.xpi";
    sha256 = "sha256-v4sHGR9zoHhfcmtt73EPFK2dTJd1D6EYiYS1M2dxG2Y=";
  };

  keepa = buildFirefoxXpiAddon rec {
    pname = "keepa";
    version = "4.10";
    addonId = "amptra@keepa.com";
    url = "https://addons.mozilla.org/firefox/downloads/file/4041807/${pname}-${version}.xpi";
    sha256 = "sha256-RzoedFBl0FTlkAmaHLgib8Rm2ePtpZYnEbzvvPOOeyQ=";
  };

  multi-account-containers = buildFirefoxXpiAddon rec {
    pname = "multi-account-containers";
    version = "8.1.3";
    addonId = "@testpilot-containers";
    url = "https://addons.mozilla.org/firefox/downloads/file/4186050/multi_account_containers-${version}.xpi";
    sha256 = "sha256-M+3ZjQ/H1H+jEPIU+JfOTf4miw+GjJ1/MrTKUFc9+Fw=";
  };

  sidebery = buildFirefoxXpiAddon rec {
    pname = "sidebery";
    version = "5.0.0";
    addonId = "{3c078156-979c-498b-8990-85f7987dd929}";
    url = "https://addons.mozilla.org/firefox/downloads/file/4170134/${pname}-${version}.xpi";
    sha256 = "sha256-9ZJCehxo0+Ua7iCNBViPOXAklpV3cf2Et2qT42QTi/U=";
  };

  sponsorblock = buildFirefoxXpiAddon rec {
    pname = "sponsorblock";
    version = "5.4.28";
    addonId = "sponsorBlocker@ajay.app";
    url = "https://addons.mozilla.org/firefox/downloads/file/4200697/${pname}-${version}.xpi";
    sha256 = "sha256-TKj2LYuAyxbNKCLTc8Uvf5+n7nbOGa7JujOZfwvJjCs=";
  };

  stylus = buildFirefoxXpiAddon rec {
    pname = "stylus";
    version = "1.5.38";
    addonId = "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}";
    url = "https://addons.mozilla.org/firefox/downloads/file/4190287/styl_us-${version}.xpi";
    sha256 = "sha256-iBuJI16KM8MjNOkiq/EaSoV9DgB8Si/xJLVEXNmZSYQ=";
  };

  tampermonkey = buildFirefoxXpiAddon rec {
    pname = "tampermonkey";
    version = "4.19.0";
    addonId = "firefox@tampermonkey.net";
    url = "https://addons.mozilla.org/firefox/downloads/file/4115771/${pname}-${version}.xpi";
    sha256 = "sha256-ImofazyaQ9g+5gHKeppy/sy3X8jpDS/rzEIyVkdB2zg=";
  };

  ublock-origin = buildFirefoxXpiAddon rec {
    pname = "ublock-origin";
    version = "1.54.0";
    addonId = "uBlock0@raymondhill.net";
    url = "https://addons.mozilla.org/firefox/downloads/file/4198829/ublock_origin-${version}.xpi";
    sha256 = "sha256-l5cWCQgZFxD/CFhTa6bcKeytmSPDCyrW0+XjcddZ5E0=";
  };
}
