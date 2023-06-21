{ ff-addons, buildFirefoxXpiAddon }:

ff-addons // {
  sidebery = buildFirefoxXpiAddon rec {
    pname = "sidebery";
    addonId = "{3c078156-979c-498b-8990-85f7987dd929}";
    version = "5.0.0b31";
    url =
      "https://github.com/mbnuqw/sidebery/releases/download/v${version}/sidebery-${version}.xpi";
    sha256 = "sha256-J7N1w7T421c0B/oZJjpJJ4AsL1YpqUYaAkJsY5IhI+Y=";
    meta = { };
  };
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
