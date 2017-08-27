{ reflex-platform, ... }:
let
  config = { allowUnfree = true; };
  pkgs = (import ../pkgs.nix { inherit config; }).pkgs;
  dontCheck = pkgs.haskell.lib.dontCheck;
  dontHaddock = pkgs.haskell.lib.dontHaddock;
in
reflex-platform.ghcjs.override {
  overrides = self: super: {
    /*aeson = self.callPackage ../../nixdeps/aeson.nix {};
    servant-swagger = self.callPackage ../../nixdeps/servant-swagger.nix {};*/
    servant = self.callPackage ../nixdeps/servant.nix {};
    bread-units-api = dontHaddock (dontCheck (self.callCabal2nix "bread-units-api" ../bread-units-api {}));
    servant-reflex = dontHaddock (dontCheck (self.callPackage ../nixdeps/servant-reflex.nix { }));
  };
}
