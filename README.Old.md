[![NPM version](https://img.shields.io/npm/v/melange-deps.svg?style=flat)](https://www.npmjs.com/package/melange-deps)

# npx melange-deps

Hack to install latest version of the [melange-re/melange](https://github.com/melange-re/melange#installation) fork of the [rescript-lang/rescript-compiler](https://github.com/rescript-lang/rescript-compiler) while its in development.

This [script](index.sh) gets the lastest hash, inserts it into `esy.json` and adds `esy.json` to your current working directory.

You must have [jq](https://stedolan.github.io/jq/download) and [esy](https://esy.sh/docs/en/getting-started.html) installed for it to work.

Building the compiler the first time will take a while. After that, anytime you run this script, it should go fast because `esy` is reusing any previously built compiler.

Also, when your are building for the browser and have a `package.json` and `esy.json`, run `npm install` first on your `package.json` then `esy` to install the `esy.json` dependencies so that `esy` can symlink to `bs-platform` in `node_modules`.

If you see a `dynamic-run` error, you can try adding `(using action-plugin 0.1)` to the [`dune-project`](https://github.com/idkjs/rescript12/pull/1/commits/6287b7f1df2817513a5bfa36bb396140b98a6bb1) file.

```dune
(lang dune 2.8)
(using action-plugin 0.1)
```

# Why
See the [blog post](https://anmonteiro.com/2021/03/on-ocaml-and-the-js-platform/).

See the [melange-re/melange/README.md](https://github.com/melange-re/melange/blob/fork/README.md) reproduced below.

At the time of this writing, running `npx melange-deps` will get you the last commit hash `aa7844b`:

```json
{
  "dependencies": {
    "bs-platform": "*"
  },
  "resolutions": {
    "bs-platform": "melange-re/melange#aa7844b",
    "ocaml": "melange-re/ocaml#75f22c8"
  },
  "esy": {
    "buildsInSource": "unsafe",
    "build": [
      "ln -sfn #{bs-platform.install} node_modules/bs-platform"
    ]
  },
  "installConfig": {
    "pnp": false
  }
}
```
**Orginal Docs**

# Melange

A _mixture_ of tooling combined to produce JS from OCaml / Reason.

This project is a fork of the
[ReScript compiler](https://github.com/rescript-lang/rescript-compiler/) with
a focus on compatibility with the wider OCaml ecosystem. A small write-up with
more details on the motivation behind this project can be found in this
[blog post](https://anmonteiro.com/2021/03/on-ocaml-and-the-js-platform/).

## Installation

This project is currently unreleased. Currently, the most straightforward way
to use it is via [Esy](https://esy.sh).

1. Make sure you have Esy installed (`npm install -g esy` should cover most
   workflows)
2. Use an `esy.json` file like the following:

```json
{
  "dependencies": {
    "bs-platform": "*"
  },
  "resolutions": {
    "bs-platform": "melange-re/melange#HASH_HERE", <- or grab the latest commit in this repo
    "ocaml": "melange-re/ocaml#75f22c8"
  },
  "esy": {
    "buildsInSource": "unsafe",
    "build": [
      "ln -sfn #{bs-platform.install} node_modules/bs-platform"
    ]
  },
  "installConfig": {
    "pnp": false
  }
}
```

3. Reach out on the [ReasonML Discord](https://discord.gg/reasonml) if you
   can't figure it out!

## FAQ

### How does this project relate to other tools?

| Name  | Purpose  | Dependencies  |  Notes |
|---|---|---|---|
| [Esy](https://esy.sh)  | Package manager |  Installed with NPM |  Obtaining dependencies (e.g. `dune` or `reason`)  |
| [Dune](https://dune.build/)  | Build tool  | Installed with `esy` | Well-known OCaml build tool; supports custom rules that can be composed to build _anything_ |
|  [Reason](https://reasonml.github.io/) | Syntax  |  Installed with `esy` | a library that implements an alternative syntax to OCaml  |
|  [Melange](https://melange.re) | Compiler that emits JavaScript  |  Esy (to install), Dune (to build), Reason (used as a library) |  Supports OCaml, Reason and ReScript syntaxes; derived from ReScript, focused on compatibility with the wider OCaml ecosystem |
|  [ReScript](https://rescript-lang.org/) | The brand around a syntax and a compiler that emits JavaScript  | None | Distributed via NPM as prebuilt binaries; previously called BuckleScript |

### Can I use ReScript syntax?

Yes! ReScript syntax is supported, but beware that it's stuck on an ancient
OCaml version (4.06, released in 2018), and it won't have as many features as
the OCaml or Reason syntaxes
(e.g. [`letop` binding operators](https://github.com/ocaml/ocaml/pull/1947),
[generalized module open expressions](https://github.com/ocaml/ocaml/pull/2147),
or [local substitutions in signatures](https://github.com/ocaml/ocaml/pull/2122)).

### Where has the `refmt` flag gone?

Upstream [removed the `refmt`](https://github.com/rescript-lang/rescript-compiler/pull/4998/commits/be9b1add647859d595dc2e2cbd5552ca246d1df9)
flag, which used to allow configuring the path to a custom Reason binary. This
was a welcome change for this repo too, so we cherry-picked it. The rationale:
this project uses [Reason](https://github.com/reasonml/reason) as a library,
so you can simply depend on the Reason version that you'd like in the usual way,
via your preferred package manager.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## Acknowledgments

See [Credits.md](./Credits.md).

## [Roadmap](https://github.com/rescript-lang/rescript-compiler/wiki)

## Licensing

See [COPYING](./COPYING) and [COPYING.LESSER](./COPYING.LESSER)

See [Credits](./Credits.md) for more details.
