{ inputs, system, ... }:
{
  # age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  # age.secrets = {
  #   getpsyched-password.file = "${inputs.self}/secrets/getpsyched-password.age";
  #   getpsyched-secrets = {
  #     file = "${inputs.self}/secrets/getpsyched-secrets.age";
  #     owner = "getpsyched";
  #   };
  #   tailscale-auth-key.file = "${inputs.self}/secrets/tailscale-auth-key.age";
  # };

  environment.systemPackages = [ inputs.agenix.packages.${system}.default ];
}
