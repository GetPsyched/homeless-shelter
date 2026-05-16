let
  users.primary = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDH+5Dygh99X3xE3oSgBHlj6aqHgjLY/rkN3tou09K88 getpsyched@brick"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMQIemRa9gFAqLjo1PI22ObcvG0bJLcgE8Hgde5wyVkq getpsyched@mitsuko"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWRWNijAXQx8sfBWCjqaSb79TPBoDD72YVIFnghP3+d getpsyched@piglin"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVFAeSyNREMi7aVTJQ+8yIhXZdxxIF3ySWmlSiaUJ2H getpsyched@puppeteer"
  ];

  hosts = {
    fledgeling = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKRAnt3jVeTeAPgX8ZUkSWxfGJas2iMbr9ggLyM9gqZ8";
    mitsuko = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFRk3dcTrePlea2pEEi0KyYc5S00oEK0SwGY0w94dpxt";
    piglin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAMOdZlxk+2X1nn0i6coQGyXBv+vPxfm0yPGAZ9srSUU";
  };
in
{
  inherit users hosts;
}
