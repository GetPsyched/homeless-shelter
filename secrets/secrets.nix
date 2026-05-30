let
  inherit (builtins) attrValues concatLists;

  keys = concatLists (attrValues (import ../keys.nix).users) ++ attrValues (import ../keys.nix).hosts;
in
{
  "cloudflare-caddy.age".publicKeys = keys;

  "restic/env.age".publicKeys = keys;
  "restic/pass.age".publicKeys = keys;

  "tailscale.age".publicKeys = keys;
  "tailscale-ephemeral.age".publicKeys = keys;
  "tailscale-server.age".publicKeys = keys;
}
