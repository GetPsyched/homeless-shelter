final: prev: {
  i3 = prev.i3.overrideAttrs (drv: {
    patches = drv.patches or [ ] ++ [
      ./i3-hide-titlebar-in-tabbed-and-stacking-modes.patch
    ];
  });
}
