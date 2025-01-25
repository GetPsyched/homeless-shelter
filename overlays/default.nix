{ ... }:
{
  additions = final: _prev: import ../packages { pkgs = final; };

  modifications = final: prev: { };
}
