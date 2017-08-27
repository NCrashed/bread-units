{ mkDerivation, aeson, aeson-compat, attoparsec, base, base-compat
, bytestring, Cabal, cabal-doctest, case-insensitive, directory
, doctest, filemanip, filepath, hspec, http-api-data, http-media
, http-types, mmorph, mtl, natural-transformation, network-uri
, QuickCheck, quickcheck-instances, stdenv, string-conversions
, tagged, text, url, vault
}:
mkDerivation {
  pname = "servant";
  version = "0.11";
  sha256 = "00vbhijdxb00n8ha068zdwvqlfqv1iradkkdchzzvnhg2jpzgcy5";
  revision = "1";
  editedCabalFile = "e36255b75b665107c8f5fe8877f8976cc7f9374bfe383b2962fa1eda448be9ab";
  setupHaskellDepends = [ base Cabal cabal-doctest ];
  libraryHaskellDepends = [
    aeson attoparsec base base-compat bytestring case-insensitive
    http-api-data http-media http-types mmorph mtl
    natural-transformation network-uri string-conversions tagged text
    vault
  ];
  testHaskellDepends = [
    aeson aeson-compat attoparsec base base-compat bytestring directory
    doctest filemanip filepath hspec QuickCheck quickcheck-instances
    string-conversions text url
  ];
  homepage = "http://haskell-servant.readthedocs.org/";
  description = "A family of combinators for defining webservices APIs";
  license = stdenv.lib.licenses.bsd3;
}

