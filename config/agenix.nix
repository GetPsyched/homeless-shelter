{ inputs, system, ... }:
{
  age.identityPaths = [ "../yubisneeze-1.txt" ];

  environment.systemPackages = [ inputs.agenix.packages.${system}.default ];
}
