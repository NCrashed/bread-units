# bread-units

This is simple example of reactive frontend in Haskell using [reflex-dom](https://github.com/reflex-frp/reflex-platform#tutorial).
The web application helps to calculate amount of sugar in a lunch in bread units (quantity of a product containing 12 grams of net carbs) and
demonstrates basic usage of reflex-dom components and design choices.

The project is entangled with slides (see reveal.js folder) and [talk](https://www.youtube.com/watch?v=x8-keXC4H88) (Russian language, sorry) given on FPConf 2016 Moscow.

## Compilation

1. Clone the repo with `--recusive` or run `git submodule update --init --recusive`
1. Install [nix](https://nixos.org/nix/) package manager (the simplest way is `curl https://nixos.org/nix/install | sh`)
1. Build frontend: `cd bread-units-frontend && ./build.sh`
1. Build backend: `nix-build release.nix`
1. Run server with: `nix-shell`
1. Go to http://localhost:8081

## Slides

1. Start backend: `cd bread-units-backend && bread-units-backend`
2. Start slides server: `cd reveal.js && npm build && npm start`

## Build with stack (legacy)

1. Build frontend: `cd bread-units-frontend && ./old_build.sh`
2. Build backend: `cd bread-units-backend && stack install`

### Known problems for stack based building

* You need `cabal-install-1.24` in your path, not `1.25`.
* You need `npm` and `node.js` installed in your OS (needed for ghcjs).
* You need `libtinfo` library with `devel` version installed in your OS.
