let
  inherit (builtins) attrValues concatLists;

  hardware-keys = {
    yubisneeze-1 = [ "age1yubikey1q0xspu5ujdkutrff6mg0p2z50haye6exh6txqa03jc90l953dzqejx735qx" ];
  };
  keys =
    concatLists (attrValues hardware-keys)
    ++ (attrValues (import ../keys.nix).users)
    ++ attrValues (import ../keys.nix).hosts;
in
{
  "cloudflare-caddy.age".publicKeys = keys;

  "restic/env.age".publicKeys = keys;
  "restic/pass.age".publicKeys = keys;

  "tailscale.age".publicKeys = keys;
  "tailscale-ephemeral.age".publicKeys = keys;
  "tailscale-server.age".publicKeys = keys;
}
