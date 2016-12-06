# bread-units

## Compilation

1. Build frontend: `cd bread-units-frontend && ./build.sh`
2. Build backend: `cd bread-units-backend && stack install`

## Slides

1. Start backend: `cd bread-units-backend && bread-units-backend`
2. Start slides server: `cd reveal.js && npm build && npm start`

## Known problems

* You need `cabal-install-1.24` in your path, not `1.25`.
* You need `npm` installed in your OS (needed for ghcjs).
* You need `libtinfo` library with `devel` version installed in your OS.
