let
  inherit (builtins) attrValues concatLists;

  keys = concatLists (attrValues (import ../keys.nix).users) ++ attrValues (import ../keys.nix).hosts;
in
{ }
