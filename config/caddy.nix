{
  config,
  inputs,
  pkgs,
  ...
}:
{
  services.caddy = {
    enable = true;

    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
      hash = "sha256-bzMqxWTqrJ1skZmRTXyEMCKStXpljbqe5r0Ve2cnBfM=";
    };
    globalConfig = ''
      acme_dns cloudflare {file.${config.age.secrets.cloudflare-caddy.path}}
    '';

    virtualHosts."*.internal.getpsyched.dev".extraConfig = ''
      respond 404
    '';
  };

  age.secrets.cloudflare-caddy = {
    file = "${inputs.self}/secrets/cloudflare-caddy.age";
    owner = "caddy";
  };
}
