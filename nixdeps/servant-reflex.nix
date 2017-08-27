{ pkgs, mkDerivation, base, bytestring, case-insensitive, containers
, data-default, exceptions, fetchgit, ghcjs-dom, http-api-data
, http-media, jsaddle, mtl, network-uri, reflex, reflex-dom, safe
, servant, servant-auth, stdenv, string-conversions, text
, transformers
}:
mkDerivation {
  pname = "servant-reflex";
  version = "0.3.1";
  src = fetchgit {
    url = "https://github.com/NCrashed/servant-reflex.git";
    sha256 = "042yw5r3y4n4s0p5lyhcrw0pc4qfwsvf6p95ccapmqijnaa2zw5h";
    rev = "4ba8a3c1434bb5daec005e1cb53a9363c3253d9e";
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base bytestring case-insensitive containers data-default exceptions
    ghcjs-dom http-api-data http-media jsaddle mtl network-uri reflex
    reflex-dom safe servant servant-auth string-conversions text
    transformers
  ];
  doHaddock = false;
  doCheck = false;
  description = "Servant reflex API generator";
  license = stdenv.lib.licenses.bsd3;
}
