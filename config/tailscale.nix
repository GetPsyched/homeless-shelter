{ config, inputs, ... }:
{
  services.tailscale = {
    enable = true;
    openFirewall = true;

    authKeyFile = config.age.secrets.tailscale.path;
    extraUpFlags = [ "--ssh" ];
  };
  persist.state.directories = [ "/var/lib/tailscale" ];

  networking.firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];

  age.secrets.tailscale = {
    file = "${inputs.self}/secrets/tailscale.age";
    owner = config.users.users.primary.name;
    group = config.users.users.primary.group; # https://github.com/ryantm/agenix/issues/374
  };
}
