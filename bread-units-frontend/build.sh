#!/usr/bin/env bash

# Build front for fast debugging cycle
../reflex-platform/work-on ./overrides.nix ./. --run "cabal configure --ghcjs && cabal build"
cp dist/build/bread-units-frontend/bread-units-frontend.jsexe/all.js ../bread-units-backend/static/all.js
