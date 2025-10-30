{ inputs, ... }:
{
  imports = [ inputs.hjem.nixosModules.default ];

  hjem = {
    clobberByDefault = true;
    extraModules = [ inputs.hjem-rum.hjemModules.default ];
    # linker = inputs.hjem.packages.smfh;
  };
}
