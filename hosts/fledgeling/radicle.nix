{ config, ... }:

let
  cfg = config.services.radicle;
  externalAddress = "radicle.getpsyched.dev";
in
{
  services.caddy.virtualHosts.${externalAddress}.extraConfig = with cfg.httpd; ''
    encode zstd gzip
    reverse_proxy ${listenAddress}:${toString listenPort}
  '';

  services.radicle = {
    enable = true;

    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAlrNWlbROfSPv6DFgMfSSY5HbjAzJgmVPfHmo0Z5tZ3";
    privateKeyFile = "/var/lib/radicle/keys/radicle";

    node.openFirewall = true;
    node.listenAddress = "[::0]";

    httpd.enable = true;

    settings = {
      node.alias = externalAddress;
      node.externalAddresses = [
        "${externalAddress}:${toString cfg.node.listenPort}"
      ];
      web = {
        description = "screw microsoft";
        pinned.repositories = [ "rad:z4PNsDYgqXuU4AvCZPTtrVHcnftdK" ];
      };
    };
  };
}
