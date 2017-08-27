let
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {
          /*aeson = haskellPackagesNew.callPackage ./nixdeps/aeson.nix {};*/
          /*text-normalize = haskellPackagesNew.callCabal2nix "text-normalize" ./text-normalize { };*/
          bread-units-api = haskellPackagesNew.callCabal2nix "bread-units-api" ./bread-units-api { };
          bread-units-backend = haskellPackagesNew.callCabal2nix "bread-units-backend" ./bread-units-backend { };
        };
      };
    };
  };

  pkgs = import ./pkgs.nix { inherit config; };
  justStaticExecutables = pkgs.haskell.lib.justStaticExecutables;
in
  { bread-units-backend = justStaticExecutables pkgs.haskellPackages.bread-units-backend;
  }
