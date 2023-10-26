{ ff-addons, buildFirefoxXpiAddon }:

ff-addons // {
  tampermonkey = buildFirefoxXpiAddon rec {
    pname = "tampermonkey";
    addonId = "firefox@tampermonkey.net";
    version = "4.18.1";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/4030629/tampermonkey-${version}.xpi";
    sha256 = "sha256-7bQ4EnMOW42GZYneerjYDnkyyrSaL6ENK8K4vjdOvN4=";
    meta = { };
  };
}
