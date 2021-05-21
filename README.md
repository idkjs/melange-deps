[![NPM version](https://img.shields.io/npm/v/melange-deps.svg?style=flat)](https://www.npmjs.com/package/melange-deps)

# npx melange-deps
Running `npx melange-deps` will get you:

```json
{
  "dependencies": {
    "@opam/ocaml-lsp-server": "*",
    "melange": "melange-re/melange",
    "ocaml": "4.12.x"
  },
  "esy": {
    "buildsInSource": "unsafe",
    "build": [
      "ln -sfn #{melange.install} node_modules/bs-platform"    ]
  },
  "installConfig": {
    "pnp": false
  }
}
```

# Why
See the [blog post](https://anmonteiro.com/2021/03/on-ocaml-and-the-js-platform/).

See the [melange-re/melange/README.md](https://github.com/melange-re/melange/blob/fork/README.md) reproduced below.

