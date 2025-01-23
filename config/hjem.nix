{ inputs, ... }:
{
  imports = [ inputs.hjem.nixosModules.hjem ];

  hjem.clobberByDefault = true;
}
